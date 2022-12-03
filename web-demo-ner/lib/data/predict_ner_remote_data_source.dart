import 'dart:convert';

import 'package:demoner/data/predict_ner_response.dart';
import 'package:http/http.dart' as http;

abstract class PredictNerRemoteDataSource {
  Future<PredictNerResponse> predictNer(String text);
}

class PredictNerRemoteDataSourceImpl extends PredictNerRemoteDataSource {
  @override
  Future<PredictNerResponse> predictNer(String text) async {
    final url = 'http://192.168.1.3:9999/api/predict';
    var param = {"text": text};
    final headers = {'Content-Type': 'application/json'};
    final dataRequest = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(param));

    final decodeJSON = json.decode(dataRequest.body ?? "");
    final uploadImageResponse = PredictNerResponse.fromJson(decodeJSON);
    return uploadImageResponse;
  }
}
