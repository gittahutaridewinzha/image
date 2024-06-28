// To parse this JSON data, do
//
//     final modelEdit = modelEditFromJson(jsonString);

import 'dart:convert';

ModelEdit modelEditFromJson(String str) => ModelEdit.fromJson(json.decode(str));

String modelEditToJson(ModelEdit data) => json.encode(data.toJson());

class ModelEdit {
  bool isSuccess;
  int value;
  String message;
  Data data;

  ModelEdit({
    required this.isSuccess,
    required this.value,
    required this.message,
    required this.data,
  });

  factory ModelEdit.fromJson(Map<String, dynamic> json) => ModelEdit(
    isSuccess: json["is_success"],
    value: json["value"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "value": value,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String id;
  String firstName;
  String lastName;
  String noHp;
  String email;

  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.noHp,
    required this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
