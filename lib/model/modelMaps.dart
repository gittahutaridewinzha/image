// To parse this JSON data, do
//
//     final modelMaps = modelMapsFromJson(jsonString);

import 'dart:convert';

ModelMaps modelMapsFromJson(String str) => ModelMaps.fromJson(json.decode(str));

String modelMapsToJson(ModelMaps data) => json.encode(data.toJson());

class ModelMaps {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelMaps({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelMaps.fromJson(Map<String, dynamic> json) => ModelMaps(
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
  String nama;
  String lokasi;
  String gambar;
  String latKampus;
  String longKampus;
  String profile;

  Datum({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.gambar,
    required this.latKampus,
    required this.longKampus,
    required this.profile,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nama: json["nama"],
    lokasi: json["lokasi"],
    gambar: json["gambar"],
    latKampus: json["lat_kampus"],
    longKampus: json["long_kampus"],
    profile: json["profile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "lokasi": lokasi,
    "gambar": gambar,
    "lat_kampus": latKampus,
    "long_kampus": longKampus,
    "profile": profile,
  };
}
