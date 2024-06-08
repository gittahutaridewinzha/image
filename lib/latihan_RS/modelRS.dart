// To parse this JSON data, do
//
//     final modelRs = modelRsFromJson(jsonString);

import 'dart:convert';

ModelRs modelRsFromJson(String str) => ModelRs.fromJson(json.decode(str));

String modelRsToJson(ModelRs data) => json.encode(data.toJson());

class ModelRs {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelRs({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelRs.fromJson(Map<String, dynamic> json) => ModelRs(
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
  String idRs;
  String idKabupaten;
  String namaRs;
  String deskripsi;
  String gambar;
  String alamat;
  String noTelp;

  Datum({
    required this.idRs,
    required this.idKabupaten,
    required this.namaRs,
    required this.deskripsi,
    required this.gambar,
    required this.alamat,
    required this.noTelp,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idRs: json["id_rs"],
    idKabupaten: json["id_kabupaten"],
    namaRs: json["nama_rs"],
    deskripsi: json["deskripsi"],
    gambar: json["gambar"],
    alamat: json["alamat"],
    noTelp: json["no_telp"],
  );

  Map<String, dynamic> toJson() => {
    "id_rs": idRs,
    "id_kabupaten": idKabupaten,
    "nama_rs": namaRs,
    "deskripsi": deskripsi,
    "gambar": gambar,
    "alamat": alamat,
    "no_telp": noTelp,
  };
}
