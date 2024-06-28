// To parse this JSON data, do
//
//     final modelList = modelListFromJson(jsonString);

import 'dart:convert';

ModelList modelListFromJson(String str) => ModelList.fromJson(json.decode(str));

String modelListToJson(ModelList data) => json.encode(data.toJson());

class ModelList {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelList({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelList.fromJson(Map<String, dynamic> json) => ModelList(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String firstName;
  String lastName;
  String noHp;
  String email;

  Datum({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.noHp,
    required this.email,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    noHp: json["noHp"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "noHp": noHp,
    "email": email,
  };
}
