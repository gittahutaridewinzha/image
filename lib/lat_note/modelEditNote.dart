// To parse this JSON data, do
//
//     final modelEditNote = modelEditNoteFromJson(jsonString);

import 'dart:convert';

ModelEditNote modelEditNoteFromJson(String str) => ModelEditNote.fromJson(json.decode(str));

String modelEditNoteToJson(ModelEditNote data) => json.encode(data.toJson());

class ModelEditNote {
  bool isSuccess;
  String message;

  ModelEditNote({
    required this.isSuccess,
    required this.message,
  });

  factory ModelEditNote.fromJson(Map<String, dynamic> json) => ModelEditNote(
    isSuccess: json["isSuccess"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
  };
}
