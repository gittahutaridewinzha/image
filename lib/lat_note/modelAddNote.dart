// To parse this JSON data, do
//
//     final modelAddNote = modelAddNoteFromJson(jsonString);

import 'dart:convert';

ModelAddNote modelAddNoteFromJson(String str) => ModelAddNote.fromJson(json.decode(str));

String modelAddNoteToJson(ModelAddNote data) => json.encode(data.toJson());

class ModelAddNote {
  int value;
  String message;
  Data data;

  ModelAddNote({
    required this.value,
    required this.message,
    required this.data,
  });

  factory ModelAddNote.fromJson(Map<String, dynamic> json) => ModelAddNote(
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
  int id;
  String judul;
  String isi;

  Data({
    required this.id,
    required this.judul,
    required this.isi,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    judul: json["judul"],
    isi: json["isi"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul": judul,
    "isi": isi,
  };
}
