import torch
from transformers import AutoModel, AutoTokenizer, RobertaConfig
from vncorenlp import VnCoreNLP
import copy
import json
import argparse
import torch.nn as nn
from pytorchcrf import CRF
from transformers.models.roberta.modeling_roberta import RobertaPreTrainedModel, RobertaModel
import numpy as np


class SlotClassifier(nn.Module):
    def __init__(
            self,
            input_dim,
            num_slot_labels,
            dropout_rate=0.0,
    ):
        super(SlotClassifier, self).__init__()
        self.num_slot_labels = num_slot_labels
        self.dropout = nn.Dropout(dropout_rate)
        self.linear = nn.Linear(input_dim, num_slot_labels)

    def forward(self, x):
        x = self.dropout(x)
        return self.linear(x)


class ViHnBERT(RobertaPreTrainedModel):
    def __init__(self, config, args, slot_label_lst):
        super(ViHnBERT, self).__init__(config)
        self.args = args
        self.num_slot_labels = len(slot_label_lst)
        self.roberta = RobertaModel(config)  # Load pretrained bert

        self.slot_classifier = SlotClassifier(
            config.hidden_size,
            self.num_slot_labels,
            args.dropout_rate,
        )

        if args.use_crf:
            self.crf = CRF(num_tags=self.num_slot_labels, batch_first=True)

    def forward(self, input_ids, attention_mask, token_type_ids=None, slot_labels_ids=None):
        outputs = self.roberta(
            input_ids, attention_mask=attention_mask, token_type_ids=token_type_ids
        )  # sequence_output, pooled_output, (hidden_states), (attentions)
        sequence_output = outputs[0]
        pooled_output = outputs[1]  # [CLS]

        slot_logits = self.slot_classifier(sequence_output)

        total_loss = 0

        # 2. Slot Softmax
        if slot_labels_ids is not None:
            if self.args.use_crf:
                slot_loss = self.crf(slot_logits, slot_labels_ids, mask=attention_mask.byte(), reduction="mean")
                slot_loss = -1 * slot_loss  # negative log-likelihood
            else:
                slot_loss_fct = nn.CrossEntropyLoss()
                # Only keep active parts of the loss
                if attention_mask is not None:
                    active_loss = attention_mask.view(-1) == 1
                    active_logits = slot_logits.view(-1, self.num_slot_labels)[active_loss]
                    active_labels = slot_labels_ids.view(-1)[active_loss]
                    slot_loss = slot_loss_fct(active_logits, active_labels)
                else:
                    slot_loss = slot_loss_fct(slot_logits.view(-1, self.num_slot_labels), slot_labels_ids.view(-1))
            total_loss += slot_loss

        outputs = ((slot_logits),) + outputs[2:]  # add hidden states and attention if they are here

        outputs = (total_loss,) + outputs

        return outputs  # (loss), logits, (hidden_states), (attentions) # Logits is a tuple of intent and slot logits


class InputFeatures(object):
    """A single set of features of data."""

    def __init__(self, input_ids, attention_mask, token_type_ids, slot_labels_ids):
        self.input_ids = input_ids
        self.attention_mask = attention_mask
        self.token_type_ids = token_type_ids
        self.slot_labels_ids = slot_labels_ids

    def __repr__(self):
        return str(self.to_json_string())

    def to_dict(self):
        """Serializes this instance to a Python dictionary."""
        output = copy.deepcopy(self.__dict__)
        return output

    def to_json_string(self):
        """Serializes this instance to a JSON string."""
        return json.dumps(self.to_dict(), indent=2, sort_keys=True) + "\n"


class InputExample(object):
    """
    A single training/test example for simple sequence classification.

    Args:
        guid: Unique id for the example.
        words: list. The words of the sequence.
        intent_label: (Optional) string. The intent label of the example.
        slot_labels: (Optional) list. The slot labels of the example.
    """

    def __init__(self, guid, words, slot_labels=None):
        self.guid = guid
        self.words = words
        self.slot_labels = slot_labels

    def __repr__(self):
        return str(self.to_json_string())

    def to_dict(self):
        """Serializes this instance to a Python dictionary."""
        output = copy.deepcopy(self.__dict__)
        return output

    def to_json_string(self):
        """Serializes this instance to a JSON string."""
        return json.dumps(self.to_dict(), indent=2, sort_keys=True) + "\n"


def convert_examples_to_features(
        examples,
        max_seq_len,
        tokenizer,
        pad_token_label_id=-100,
        cls_token_segment_id=0,
        pad_token_segment_id=0,
        sequence_a_segment_id=0,
        mask_padding_with_zero=True,
):
    # Setting based on the current model type
    cls_token = tokenizer.cls_token
    sep_token = tokenizer.sep_token
    unk_token = tokenizer.unk_token
    pad_token_id = tokenizer.pad_token_id

    features = []
    for (ex_index, example) in enumerate(examples):

        # Tokenize word by word (for NER)
        tokens = []
        slot_labels_ids = []
        for word, slot_label in zip(example.words, example.slot_labels):
            word_tokens = tokenizer.tokenize(word)
            if not word_tokens:
                word_tokens = [unk_token]  # For handling the bad-encoded word
            tokens.extend(word_tokens)
            # Use the real label id for the first token of the word, and padding ids for the remaining tokens
            slot_labels_ids.extend([int(slot_label)] + [pad_token_label_id] * (len(word_tokens) - 1))

        # Account for [CLS] and [SEP]
        special_tokens_count = 2
        if len(tokens) > max_seq_len - special_tokens_count:
            tokens = tokens[: (max_seq_len - special_tokens_count)]
            slot_labels_ids = slot_labels_ids[: (max_seq_len - special_tokens_count)]

        # Add [SEP] token
        tokens += [sep_token]
        slot_labels_ids += [pad_token_label_id]
        token_type_ids = [sequence_a_segment_id] * len(tokens)

        # Add [CLS] token
        tokens = [cls_token] + tokens
        slot_labels_ids = [pad_token_label_id] + slot_labels_ids
        token_type_ids = [cls_token_segment_id] + token_type_ids

        input_ids = tokenizer.convert_tokens_to_ids(tokens)

        # The mask has 1 for real tokens and 0 for padding tokens. Only real
        # tokens are attended to.
        attention_mask = [1 if mask_padding_with_zero else 0] * len(input_ids)

        # Zero-pad up to the sequence length.
        padding_length = max_seq_len - len(input_ids)
        input_ids = input_ids + ([pad_token_id] * padding_length)
        attention_mask = attention_mask + ([0 if mask_padding_with_zero else 1] * padding_length)
        token_type_ids = token_type_ids + ([pad_token_segment_id] * padding_length)
        slot_labels_ids = slot_labels_ids + ([pad_token_label_id] * padding_length)

        assert len(input_ids) == max_seq_len, "Error with input length {} vs {}".format(len(input_ids), max_seq_len)
        assert len(attention_mask) == max_seq_len, "Error with attention mask length {} vs {}".format(
            len(attention_mask), max_seq_len
        )
        assert len(token_type_ids) == max_seq_len, "Error with token type length {} vs {}".format(
            len(token_type_ids), max_seq_len
        )
        assert len(slot_labels_ids) == max_seq_len, "Error with slot labels length {} vs {}".format(
            len(slot_labels_ids), max_seq_len
        )

        features.append(
            InputFeatures(
                input_ids=input_ids,
                attention_mask=attention_mask,
                token_type_ids=token_type_ids,
                slot_labels_ids=slot_labels_ids,
            )
        )

    return features


def _create_examples(texts, label):
    """Creates examples for the training and dev sets."""
    examples = []
    guid = "predict"
    # 1. input_text
    words = texts.split(" ")  # Some are spaced twice
    slots = ["O"] * len(words)

    # 2. slot
    slot_labels = []
    for s in slots:
        slot_labels.append(label.index(s) if s in label else slot_labels.index("O"))
    try:
        assert len(words) == len(slot_labels)
    except:
        print(words)
        print(slot_labels)
        print(len(words))
        print(len(slot_labels))
    examples.append(InputExample(guid=guid, words=words, slot_labels=slot_labels))
    return examples


if __name__ == "__main__":

    """
    Labels
    """
    labels = ["O", "B-DATE", "I-DATE", "B-NAME", "B-AGE", "B-LOCATION", "I-LOCATION", "B-JOB", "I-JOB",
              "B-ORGANIZATION", "I-ORGANIZATION", "B-PATIENT_ID", "B-SYMPTOM_AND_DISEASE", "I-SYMPTOM_AND_DISEASE",
              "B-GENDER", "B-TRANSPORTATION", "I-TRANSPORTATION", "I-NAME", "I-PATIENT_ID", "I-AGE", "I-GENDER"]

    # Input
    text = "Thưa bác sĩ, dạo này em bị ho có đờm, chóng mặt, buồn nôn, hay bị tiêu chảy."
    max_seq_len = 70

    """
    Step 1: 
        To perform word (and sentence) segmentation with VnCoreNLP
        https://huggingface.co/demdecuong/vihealthbert-base-word#example-usage-for-raw-text-
    """
    rdrsegmenter = VnCoreNLP("vncorenlp/VnCoreNLP-1.1.1.jar",
                             annotators="wseg",
                             max_heap_size='-Xmx500m')
    sentences = rdrsegmenter.tokenize(text)
    input_text = ""
    for sentence in sentences:
        input_text = " ".join(sentence)

    """
    Step 2
        Create example Input
    """
    example = _create_examples(input_text, labels)

    """
    Step 3
        Create feature Input consist of:
          + all_input_ids
          + all_attention_mask
          + all_slot_labels_ids : default [O] * len(input_text_segmentation)
    """
    pretrain_tokenizer = AutoTokenizer.from_pretrained("demdecuong/vihealthbert-base-word")
    feature = convert_examples_to_features(example, max_seq_len=max_seq_len, tokenizer=pretrain_tokenizer,
                                           pad_token_label_id=0)
    all_input_ids = torch.tensor([[f for f in feature[0].input_ids]], dtype=torch.long)
    all_attention_mask = torch.tensor([[f for f in feature[0].attention_mask]], dtype=torch.long)
    all_slot_labels_ids = torch.tensor([[f for f in feature[0].slot_labels_ids]], dtype=torch.long)
    with torch.no_grad():
        inputs = {
            "input_ids": all_input_ids,
            "attention_mask": all_attention_mask,
            "slot_labels_ids": all_slot_labels_ids,
        }

    """
        Step 4: 
            Config for pretrained model
    """
    parser = argparse.ArgumentParser()
    parser.add_argument("--use_crf", action="store_true", help="Whether to use CRF")
    parser.add_argument("--dropout_rate", default=0.1, type=float, help="Dropout for fully-connected layers")
    args = parser.parse_args()

    # Using pretrained RobertaConfig for finetuning task
    config = RobertaConfig.from_pretrained('demdecuong/vihealthbert-base-word', finetuning_task='')

    # Load model ViHnBert from path
    model = ViHnBERT.from_pretrained(
        'model-save',
        config=config,
        args=args,
        slot_label_lst=labels,
    )
    outputs = model(**inputs)

    """
        Step 5:
            Get index label predict
    """
    tmp_eval_loss, (slot_logits) = outputs[:2]
    slot_preds = slot_logits.detach().cpu().numpy()
    slot_preds = np.argmax(slot_preds, axis=2).flatten()

    """
        Step 5:
            Remove padding
    """
    padding = max_seq_len - len(input_text.split(" "))
    predict_ner = slot_preds[:(len(slot_preds) - padding + 1)]
    index = [0]
    new_predict_ner = np.delete(predict_ner, index)

    # Output Data
    print(f"Raw text: {text}")
    print(new_predict_ner)
    for token, label in zip(input_text.split(" "), new_predict_ner):
        print("{}\t{}".format(labels[label], token))
