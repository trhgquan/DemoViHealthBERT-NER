import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_demo_ner/data/predict_ner_response.dart';

abstract class PredictNerRemoteDataSource {
  Future<PredictNerResponse> predictNer(String text);
}

class PredictNerRemoteDataSourceImpl extends PredictNerRemoteDataSource {
  @override
  Future<PredictNerResponse> predictNer(String text) async {
    const serverUrl = "http://192.168.1.213:9999";
    const url = "$serverUrl/api/predict";
    var param = {"text": text};
    final headers = {'Content-Type': 'application/json'};
    final dataRequest = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(param));

    final decodeJSON = json.decode(dataRequest.body ?? "");
    final uploadImageResponse = PredictNerResponse.fromJson(decodeJSON);
    return uploadImageResponse;
  }
}
