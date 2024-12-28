import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/list_siswa/add.dart';
import 'package:image/list_siswa/detail_siswa.dart';
import 'package:image/list_siswa/edit.dart';
import 'package:image/list_siswa/modelDelete.dart';

import 'dart:convert';

import 'package:image/list_siswa/modelpegawai.dart';

class PageListSiswa extends StatefulWidget {
  const PageListSiswa({super.key});

  @override
  State<PageListSiswa> createState() => _PageListSiswaState();
}

class _PageListSiswaState extends State<PageListSiswa> {
  Future<List<Datum>?> getData() async {
    try {
      http.Response res = await http.get(
        Uri.parse('http://172.26.16.1:7070/list_pegawai.php'),
      );
      return modelpegawaiFromJson(res.body).data;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      });
    }
  }

  Future<void> deleteData(String id) async {
    try {
      final response = await http.post(
        Uri.parse('http://172.26.16.1:7070/delete.php'),
        body: {'id': id},
      );

      if (response.statusCode == 200) {
        // Parse response using ModelDelete
        final result = ModelDelete.fromJson(json.decode(response.body));

        if (result.isSuccess) {
          // Refresh data after deletion
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result.message)),
          );
          setState(() {
            getData(); // Refresh data on successful delete
          });
        } else {
          throw Exception(result.message);
        }
      } else {
        throw Exception('Failed to delete data from server.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete data: $e')),
      );
    }
  }

  void confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteData(id);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Pegawai',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Datum? data = snapshot.data?[index];
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.purple,
                                child: Text(
                                  '${data?.nama[0]}',
                                  style: TextStyle(color: Colors.white, fontSize: 24),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Nama: ${data?.nama}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Email: ${data?.email}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Jenis Kelamin: ${data?.jenisKelamin}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Alamat: ${data?.alamat}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.purple),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PageEditPegawai(data: data!), // Pass the entire Datum object
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  confirmDelete(data!.id);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.remove_red_eye_sharp, color: Colors.purple),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Detail(data: data!), // Pass the entire Datum object
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.purple),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageAdd(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
