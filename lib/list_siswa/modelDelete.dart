// To parse this JSON data, do
//
//     final modelDelete = modelDeleteFromJson(jsonString);

import 'dart:convert';

ModelDelete modelDeleteFromJson(String str) => ModelDelete.fromJson(json.decode(str));

String modelDeleteToJson(ModelDelete data) => json.encode(data.toJson());

class ModelDelete {
  bool isSuccess;
  String message;

  ModelDelete({
    required this.isSuccess,
    required this.message,
  });

  factory ModelDelete.fromJson(Map<String, dynamic> json) => ModelDelete(
    isSuccess: json["isSuccess"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
  };
}
