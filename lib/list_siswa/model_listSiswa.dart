// To parse this JSON data, do
//
//     final modelListSiswa = modelListSiswaFromJson(jsonString);

import 'dart:convert';

ModelListSiswa modelListSiswaFromJson(String str) => ModelListSiswa.fromJson(json.decode(str));

String modelListSiswaToJson(ModelListSiswa data) => json.encode(data.toJson());

class ModelListSiswa {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelListSiswa({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelListSiswa.fromJson(Map<String, dynamic> json) => ModelListSiswa(
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
  DateTime tglLahir;
  String jenisKelamin;
  String email;
  String noHp;
  String alamat;
  String password;

  Datum({
    required this.id,
    required this.nama,
    required this.tglLahir,
    required this.jenisKelamin,
    required this.email,
    required this.noHp,
    required this.alamat,
    required this.password,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nama: json["nama"],
    tglLahir: DateTime.parse(json["tgl_lahir"]),
    jenisKelamin: json["jenis_kelamin"],
    email: json["email"],
    noHp: json["no_hp"],
    alamat: json["alamat"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "tgl_lahir": "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
    "jenis_kelamin": jenisKelamin,
    "email": email,
    "no_hp": noHp,
    "alamat": alamat,
    "password": password,
  };
}
