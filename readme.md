# Demo ViHealthBERT for NER task

This is a demo repository for Text Mining (MTH089) @ VNUHCM - University of Science, Winter 2022.

Shout out to [**Pham Anh Viet**](https://github.com/AnhVietPham), **Nguyen Thien Duong** and **Nguyen Duc Thuan** for their great contributon on this project.

# Abstract
Based on the paper **ViHealthBERT: Pre-trained Language Models for Vietnamese in Health Text Mining**[^1], we fine-tuned the ViHealthBERT model for the NER task using the PhoNER_COVID19 dataset[^2]. 

[^1]: [ViHealthBERT: Pre-trained Language Models for Vietnamese in Health Text Mining](https://aclanthology.org/2022.lrec-1.35) (Minh et al., LREC 2022)
[^2]: [COVID-19 Named Entity Recognition for Vietnamese](https://aclanthology.org/2021.naacl-main.173) (Truong et al., NAACL 2021)

# Setup

## For the server

### 1. Install Java
Follow the guidelines in https://gist.github.com/wavezhang/ba8425f24a968ec9b2a8619d7c2d86a6 to **download Java without an Oracle account**.
- JDK / JRE version required: **at least 1.8**
- [**Remember to add Java runtime to your system variable - Windows only!**](https://stackoverflow.com/questions/3518172/how-do-i-set-the-path-environment-variable-to-point-to-jre-version-1-5)

### 2. Install VnCoreNLP
Run `vncorenlp.sh` to download the pretrained VnCoreNLP, 
- Or, follow the guidelines in https://github.com/vncorenlp/VnCoreNLP

### 3. Install other packages
```
pip install -r requirements.txt
```

### 4. Download the fine-tuned ViHealthBERT-NER pretrain
Follow [this link](https://drive.google.com/drive/u/0/folders/19AGLo-27EeuXDkKG2JstuCgrcwB0854r). The directory tree after this step should looks something like this:

```
DemoViHealthBERT-NER
|   .gitignore
|   main.py
|   data_loader.py
|   readme.md
|   requirements.txt
|   vncorenlp.sh
+---model
|       module.py
|       vihnbert.py
+---model-save
|       config.json
|       pytorch_model.bin
|       training_args.bin
|
+---web-demo-ner
|
\---vncorenlp
    |   VnCoreNLP-1.1.1.jar
    |
    \---models
        \---wordsegmenter
                vi-vocab
                wordsegmenter.rdr
```


Everything should be fine after this section. Now run and **remember the server's url**.
```
python main.py
```
The server's url can be found on the terminal:
```
Running on http://ipaddress:port (Press Ctrl+C to quit)
```

## For the web application
### 1. Install Flutter SDK
https://docs.flutter.dev/get-started/install

### 2. Configure API server address
- Open `web-demo-ner/lib/data/predict_ner_remote_data_source.dart`
- Update `serverUrl` to the `http://ipaddress:port` above.

### 3. Running the Web
- List out all available devices:
    ```
    flutter devices
    ```
- Using one of the devices above (e.g. `edge`):
    ```
    cd web-demo-ner
    flutter run -d edge
    ```

The web should start after a while. 
