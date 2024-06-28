// To parse this JSON data, do
//
//     final modelDeleteNote = modelDeleteNoteFromJson(jsonString);

import 'dart:convert';

ModelDeleteNote modelDeleteNoteFromJson(String str) => ModelDeleteNote.fromJson(json.decode(str));

String modelDeleteNoteToJson(ModelDeleteNote data) => json.encode(data.toJson());

class ModelDeleteNote {
  bool isSuccess;
  String message;

  ModelDeleteNote({
    required this.isSuccess,
    required this.message,
  });

  factory ModelDeleteNote.fromJson(Map<String, dynamic> json) => ModelDeleteNote(
    isSuccess: json["isSuccess"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
  };
}
