import 'dart:convert';

class PredictNerResponse {
  PredictNerResponse({
    this.result,
  });

  Result? result;

  factory PredictNerResponse.fromJson(Map<String, dynamic> json) =>
      PredictNerResponse(
        result: Result.fromJson(json["result"]),
      );
}

class Result {
  Result({
    this.status,
    this.data,
    this.symptoms
  });

  int? status;
  List<Data>? data;
  List<String>? symptoms;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      status: json["status"],
      data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      symptoms: List<String>.from(json['symptoms_list'].map((x) => x)));
}

class Data {
  Data({
    this.token,
    this.label,
  });

  String? token;
  String? label;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        label: json["label"],
      );
}
