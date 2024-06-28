// To parse this JSON data, do
//
//     final modelNote = modelNoteFromJson(jsonString);

import 'dart:convert';

ModelNote modelNoteFromJson(String str) => ModelNote.fromJson(json.decode(str));

String modelNoteToJson(ModelNote data) => json.encode(data.toJson());

class ModelNote {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelNote({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelNote.fromJson(Map<String, dynamic> json) => ModelNote(
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
  String judul;
  String isi;

  Datum({
    required this.id,
    required this.judul,
    required this.isi,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
