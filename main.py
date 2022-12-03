import argparse
import json
import os

import numpy as np
import torch
from flask import Flask, request
from flask_restful import Resource, Api
from transformers import AutoTokenizer, RobertaConfig

from data_loader import _create_examples, convert_examples_to_features
from model.vihnbert import ViHnBERT
from vncorenlp import VnCoreNLP
from flask_cors import CORS

app = Flask(__name__)
cors = CORS(app)
api = Api(app)

""" Labels """
labels = ["O", "B-DATE", "I-DATE", "B-NAME", "B-AGE", "B-LOCATION", "I-LOCATION", "B-JOB", "I-JOB",
          "B-ORGANIZATION", "I-ORGANIZATION", "B-PATIENT_ID", "B-SYMPTOM_AND_DISEASE", "I-SYMPTOM_AND_DISEASE",
          "B-GENDER", "B-TRANSPORTATION", "I-TRANSPORTATION", "I-NAME", "I-PATIENT_ID", "I-AGE", "I-GENDER"]


def retrieve_symptoms(words, labels):
    list_symptoms = []
    current_label = []

    assert len(words) == len(labels)

    for i in range(len(words)):
        if labels[i] == "B-SYMPTOM_AND_DISEASE":
            if len(current_label) > 0:
                list_symptoms.append(" ".join(current_label).replace("_", " "))

            current_label = [words[i]]

        if labels[i] == "I-SYMPTOM_AND_DISEASE":
            current_label.append(words[i])

    return list_symptoms


def predict(text):
    max_seq_len = 70
    target_VnCoreNLP_path = os.path.join(os.path.dirname(__file__), 'vncorenlp/VnCoreNLP-1.1.1.jar')
    rdrsegmenter = VnCoreNLP(target_VnCoreNLP_path,
                             annotators="wseg",
                             max_heap_size='-Xmx500m')
    sentences = rdrsegmenter.tokenize(text)
    input_text = ""
    for sentence in sentences:
        input_text = " ".join(sentence)

    example = _create_examples(input_text, labels)

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

    parser = argparse.ArgumentParser()
    parser.add_argument("--use_crf", action="store_true", help="Whether to use CRF")
    parser.add_argument("--dropout_rate", default=0.1, type=float, help="Dropout for fully-connected layers")
    args = parser.parse_args()

    config = RobertaConfig.from_pretrained('demdecuong/vihealthbert-base-word', finetuning_task='')

    target_model_save_path = os.path.join(os.path.dirname(__file__), 'model-save')

    model = ViHnBERT.from_pretrained(
        target_model_save_path,
        config=config,
        args=args,
        slot_label_lst=labels,
    )
    outputs = model(**inputs)

    tmp_eval_loss, (slot_logits) = outputs[:2]
    slot_preds = slot_logits.detach().cpu().numpy()
    slot_preds = np.argmax(slot_preds, axis=2).flatten()

    padding = max_seq_len - len(input_text.split(" "))
    predict_ner = slot_preds[:(len(slot_preds) - padding + 1)]
    index = [0]
    new_predict_ner = np.delete(predict_ner, index)
    result = {}
    predict_labels = []
    for token, label in zip(input_text.split(" "), new_predict_ner):
        result[token] = labels[label]
        predict_labels.append(labels[label])
    symptoms_list = retrieve_symptoms(input_text.split(" "), predict_labels)
    return result, symptoms_list


class NER(Resource):
    def post(self):
        text = request.get_json()
        text = text["text"]
        data_predict, symptoms_list = predict(text)
        result = []
        for k, v in data_predict.items():
            result.append({'token': k, 'label': v})
        print(data_predict)
        return {"result": {
            "status": 200,
            "data": result,
            "symptoms_list": symptoms_list
        }}


api.add_resource(NER, "/api/predict")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9999)
