import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/lat_crud/modelEdit.dart';
import 'package:image/lat_crud/modelList.dart';

class PageEditPegawai extends StatefulWidget {
  final Datum data; // Gunakan tipe data Datum
  const PageEditPegawai({Key? key, required this.data}) : super(key: key);

  @override
  State<PageEditPegawai> createState() => _PageEditPegawaiState();
}

class _PageEditPegawaiState extends State<PageEditPegawai> {
  late TextEditingController txtFirstname;
  late TextEditingController txtLastname;
  late TextEditingController txtNohp;
  late TextEditingController txtEmail;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan nilai awal
    txtFirstname = TextEditingController(text: widget.data.firstName);
    txtLastname = TextEditingController(text: widget.data.lastName);
    txtNohp = TextEditingController(text: widget.data.noHp);
    txtEmail = TextEditingController(text: widget.data.email);
  }

  Future<void> updatePegawai() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.100.133/DBDATA/getEdit.php'),
        body: {
          'id': widget.data.id.toString(),
          'first_name': txtFirstname.text,
          'last_name': txtLastname.text,
          'noHp': txtNohp.text,
          'email': txtEmail.text,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['is_success']) {
          // Update local data
          setState(() {
            widget.data.firstName = txtFirstname.text;
            widget.data.lastName = txtLastname.text;
            widget.data.noHp = txtNohp.text;
            widget.data.email = txtEmail.text;
          });

          Navigator.pop(context, true); // Kembali ke halaman sebelumnya dengan nilai true
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengupdate data: ${jsonResponse['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghubungi server')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Edit Pegawai'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: txtFirstname,
              decoration: InputDecoration(
                hintText: 'Firstname',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: txtLastname,
              decoration: InputDecoration(
                hintText: 'Lastname',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: txtNohp,
              decoration: InputDecoration(
                hintText: 'No HP',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: txtEmail,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                updatePegawai(); // Panggil fungsi untuk update data
              },
              child: const Text("SIMPAN"),
            ),
          ],
        ),
      ),
    );
  }
}
