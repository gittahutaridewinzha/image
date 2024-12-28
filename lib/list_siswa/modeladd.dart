// To parse this JSON data, do
//
//     final modeladd = modeladdFromJson(jsonString);

import 'dart:convert';

Modeladd modeladdFromJson(String str) => Modeladd.fromJson(json.decode(str));

String modeladdToJson(Modeladd data) => json.encode(data.toJson());

class Modeladd {
  int value;
  String message;

  Modeladd({
    required this.value,
    required this.message,
  });

  factory Modeladd.fromJson(Map<String, dynamic> json) => Modeladd(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
