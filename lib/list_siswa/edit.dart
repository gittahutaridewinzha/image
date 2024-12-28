import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/list_siswa/listSiswa.dart'; // Ensure this is the correct import for your list page
import 'modelpegawai.dart'; // Import the model file

class PageEditPegawai extends StatefulWidget {
  final Datum data; // Using Datum type

  const PageEditPegawai({Key? key, required this.data}) : super(key: key);

  @override
  State<PageEditPegawai> createState() => _PageEditPegawaiState();
}

class _PageEditPegawaiState extends State<PageEditPegawai> {
  late TextEditingController txtNama;
  late TextEditingController txtTglLahir;
  late TextEditingController txtJenisKelamin; // This could also be a dropdown
  late TextEditingController txtNohp;
  late TextEditingController txtEmail;
  late TextEditingController txtAlamat;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with initial values
    txtNama = TextEditingController(text: widget.data.nama);
    txtTglLahir = TextEditingController(text: widget.data.tglLahir.toString().split(' ')[0]); // Format DateTime to String
    txtJenisKelamin = TextEditingController(text: widget.data.jenisKelamin);
    txtNohp = TextEditingController(text: widget.data.noHp);
    txtEmail = TextEditingController(text: widget.data.email);
    txtAlamat = TextEditingController(text: widget.data.alamat);
  }

  Future<void> updatePegawai() async {
    try {
      final response = await http.post(
        Uri.parse('http://172.26.16.1:7070/editpegawai.php'), // Replace with your actual endpoint
        body: {
          'id': widget.data.id,
          'nama': txtNama.text,
          'tgl_lahir': txtTglLahir.text,
          'jenis_kelamin': txtJenisKelamin.text,
          'noHp': txtNohp.text,
          'email': txtEmail.text,
          'alamat': txtAlamat.text,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['isSuccess']) {
          // Update local data
          setState(() {
            widget.data.nama = txtNama.text;
            widget.data.tglLahir = DateTime.parse(txtTglLahir.text);
            widget.data.jenisKelamin = txtJenisKelamin.text;
            widget.data.noHp = txtNohp.text;
            widget.data.email = txtEmail.text;
            widget.data.alamat = txtAlamat.text;
          });

          // Navigate to PageListSiswa
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PageListSiswa()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update data: ${jsonResponse['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to contact server')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Edit Pegawai'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: txtNama,
              decoration: InputDecoration(
                hintText: 'Nama',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: txtTglLahir,
              decoration: InputDecoration(
                hintText: 'Tanggal Lahir (YYYY-MM-DD)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode()); // To prevent keyboard from appearing
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.parse(txtTglLahir.text),
                  firstDate: DateTime(2000), // Set minimum date
                  lastDate: DateTime(2101), // Set maximum date
                );
                if (pickedDate != null) {
                  setState(() {
                    txtTglLahir.text = pickedDate.toIso8601String().split('T')[0]; // Format to YYYY-MM-DD
                  });
                }
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: txtJenisKelamin,
              decoration: InputDecoration(
                hintText: 'Jenis Kelamin',
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
            TextFormField(
              controller: txtAlamat,
              decoration: InputDecoration(
                hintText: 'Alamat',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                updatePegawai(); // Call the function to update data
              },
              child: const Text("SIMPAN"),
            ),
          ],
        ),
      ),
    );
  }
}
