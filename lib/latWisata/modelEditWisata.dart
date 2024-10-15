// To parse this JSON data, do
//
//     final modelEditWisata = modelEditWisataFromJson(jsonString);

import 'dart:convert';

ModelEditWisata modelEditWisataFromJson(String str) => ModelEditWisata.fromJson(json.decode(str));

String modelEditWisataToJson(ModelEditWisata data) => json.encode(data.toJson());

class ModelEditWisata {
  bool isSuccess;
  int value;
  String message;
  String id;
  String nama;
  String lokasi;
  String profile;
  String latWisata;
  String longWisata;
  String gambar;
  String deskripsi;

  ModelEditWisata({
    required this.isSuccess,
    required this.value,
    required this.message,
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.profile,
    required this.latWisata,
    required this.longWisata,
    required this.gambar,
    required this.deskripsi,
  });

  factory ModelEditWisata.fromJson(Map<String, dynamic> json) => ModelEditWisata(
    isSuccess: json["is_success"],
    value: json["value"],
    message: json["message"],
    id: json["id"],
    nama: json["nama"],
    lokasi: json["lokasi"],
    profile: json["profile"],
    latWisata: json["latWisata"],
    longWisata: json["longWisata"],
    gambar: json["gambar"],
    deskripsi: json["deskripsi"],
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "value": value,
    "message": message,
    "id": id,
    "nama": nama,
    "lokasi": lokasi,
    "profile": profile,
    "latWisata": latWisata,
    "longWisata": longWisata,
    "gambar": gambar,
    "deskripsi": deskripsi,
  };
}
