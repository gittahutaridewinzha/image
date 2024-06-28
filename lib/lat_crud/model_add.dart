// To parse this JSON data, do
//
//     final modelAdd = modelAddFromJson(jsonString);

import 'dart:convert';

ModelAdd modelAddFromJson(String str) => ModelAdd.fromJson(json.decode(str));

String modelAddToJson(ModelAdd data) => json.encode(data.toJson());

class ModelAdd {
  int value;
  String message;
  Data data;

  ModelAdd({
    required this.value,
    required this.message,
    required this.data,
  });

  factory ModelAdd.fromJson(Map<String, dynamic> json) => ModelAdd(
    value: json["value"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
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
