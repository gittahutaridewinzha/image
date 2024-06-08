// To parse this JSON data, do
//
//     final modelKab = modelKabFromJson(jsonString);

import 'dart:convert';

ModelKab modelKabFromJson(String str) => ModelKab.fromJson(json.decode(str));

String modelKabToJson(ModelKab data) => json.encode(data.toJson());

class ModelKab {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelKab({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelKab.fromJson(Map<String, dynamic> json) => ModelKab(
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
  String idKabupaten;
  String idProv;
  String namaKab;

  Datum({
    required this.idKabupaten,
    required this.idProv,
    required this.namaKab,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idKabupaten: json["id_kabupaten"],
    idProv: json["id_prov"],
    namaKab: json["nama_kab"],
  );

  Map<String, dynamic> toJson() => {
    "id_kabupaten": idKabupaten,
    "id_prov": idProv,
    "nama_kab": namaKab,
  };
}
