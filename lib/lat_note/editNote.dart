import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/lat_note/modelNote.dart';
import 'package:image/lat_note/pageNote.dart';



class PageEditNotes extends StatefulWidget {
  final Datum data;
  const PageEditNotes({Key? key, required this.data}): super(key: key);



  @override
  State<PageEditNotes> createState() => _PageEditNotesState();
}

class _PageEditNotesState extends State<PageEditNotes> {
  late TextEditingController txtJudul;
  late TextEditingController txtIsi;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    txtJudul = TextEditingController(text: widget.data.judul);
    txtIsi = TextEditingController(text: widget.data.isi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Edit Notes'),
      ),

      body: Form(
          key: keyForm,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    //validasi kosong
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    controller: txtJudul,
                    //initialValue: widget.data?.nama ?? "",
                    decoration: InputDecoration(
                        hintText: 'Judul',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    //validasi kosong
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    controller: txtIsi,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: 'Isi',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (keyForm.currentState?.validate() == true) {
                        // Kirim data perubahan ke server
                        http.post(
                          Uri.parse('http://10.126.121.246/note/getEdit.php'),
                          body: {
                            'id': widget.data.id.toString(),
                            'judul': txtJudul.text,
                            'isi': txtIsi.text,
                          },
                        ).then((response) {
                          if (response.statusCode == 200) {
                            var jsonResponse = json.decode(response.body);
                            if (jsonResponse['is_success'] == true) {
                              // Jika pembaruan berhasil, kembali ke halaman utama
                              Navigator.pop(context); // Redirect langsung ke halaman utama
                            } else {
                              // Jika pembaruan gagal, tampilkan pesan kesalahan
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Berhasil"),
                                    content: Text("berhasil: ${jsonResponse['message']}"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            // Jika respons server tidak berhasil, tampilkan pesan kesalahan umum
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Berhasil"),
                                  content: Text("Berhasil saat mengirim data ke server"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }).catchError((error) {
                          // Tangani kesalahan koneksi atau lainnya
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Berhasil"),
                                content: Text("Berhasil: $error"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Tutup dialog
                                      Navigator.pushReplacement( // Redirect ke halaman utama
                                        context,
                                        MaterialPageRoute(builder: (context) => PageUtama()),
                                      );
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        });
                      }
                    },
                    child: const Text("SIMPAN"),
                  ),

                ],
              ),
            ),
          )),
    );
  }
}