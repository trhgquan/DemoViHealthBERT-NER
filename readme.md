# Demo VnHealthBERT

This is a demo repository for Text Mining (MTH089) @ VNUHCM - University of Science, Winter 2022.

Shout out to [**Pham Anh Viet**](https://github.com/AnhVietPham), **Nguyen Thien Duong** and **Nguyen Duc Thuan** for their great contributon on this project.

## Abstract
Based on the paper **ViHealthBERT: Pre-trained Language Models for Vietnamese in Health Text Mining**[^1], we fine-tuned the ViHealthBERT model to create a Disease Symptoms Filter application. 

[^1]: [ViHealthBERT: Pre-trained Language Models for Vietnamese in Health Text Mining](https://aclanthology.org/2022.lrec-1.35) (Minh et al., LREC 2022)

## Setup

### 1. Install Java
Follow the guidelines in https://gist.github.com/wavezhang/ba8425f24a968ec9b2a8619d7c2d86a6 to **download Java without an Orcle account**.
- JDK / JRE version required: **at least 1.8**
- [**Remember to add Java runtime to your system variable - Windows only!**](https://stackoverflow.com/questions/3518172/how-do-i-set-the-path-environment-variable-to-point-to-jre-version-1-5)

### 2. Install VnCoreNLP
Run `vncorenlp.sh` to download the VnCoreNLP pretrained, 
- Or, follow the guidelines in https://github.com/vncorenlp/VnCoreNLP

### 3. Install other packages
```
pip install -r requirements.txt
```

### 4. Download the fine-tuned ViHealthBERT pretrain
Follow [this link](https://drive.google.com/drive/folders/1jsvgoUtTlnFSAAp_xagUDnp27T183Cal?fbclid=IwAR1ntjPEa3Fx5xKF4WbGMumvAVRyyedO_1eHEIHsZYhAEL91bkWyIKCpsB8). The directory tree after this step should looks something like this:

```
DemoVnHealthBERT
|   .gitignore
|   main.py
|   readme.md
|   requirements.txt
|   vncorenlp.sh
|
+---model-save
|       config.json
|       eval_dev_results.txt
|       eval_test_results.txt
|       events.out.tfevents.1667922466.cb80415698cc.105.1
|       pytorch_model.bin
|       training_args.bin
|
\---vncorenlp
    |   VnCoreNLP-1.1.1.jar
    |
    \---models
        \---wordsegmenter
                vi-vocab
                wordsegmenter.rdr
```


Everything should be fine after this section.