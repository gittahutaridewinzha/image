// To parse this JSON data, do
//
//     final modelKamar = modelKamarFromJson(jsonString);

import 'dart:convert';

ModelKamar modelKamarFromJson(String str) => ModelKamar.fromJson(json.decode(str));

String modelKamarToJson(ModelKamar data) => json.encode(data.toJson());

class ModelKamar {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelKamar({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelKamar.fromJson(Map<String, dynamic> json) => ModelKamar(
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
  String idKamar;
  String idRs;
  String namaKmr;
  String jumlahKmr;
  String tersedia;
  String latRs;
  String longRs;

  Datum({
    required this.idKamar,
    required this.idRs,
    required this.namaKmr,
    required this.jumlahKmr,
    required this.tersedia,
    required this.latRs,
    required this.longRs,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idKamar: json["id_kamar"],
    idRs: json["id_rs"],
    namaKmr: json["nama_kmr"],
    jumlahKmr: json["jumlah_kmr"],
    tersedia: json["tersedia"],
    latRs: json["lat_rs"],
    longRs: json["long_rs"],
  );

  Map<String, dynamic> toJson() => {
    "id_kamar": idKamar,
    "id_rs": idRs,
    "nama_kmr": namaKmr,
    "jumlah_kmr": jumlahKmr,
    "tersedia": tersedia,
    "lat_rs": latRs,
    "long_rs": longRs,
  };
}
