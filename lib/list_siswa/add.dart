import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/list_siswa/listSiswa.dart';
import 'dart:convert';
import 'package:image/list_siswa/model_register.dart'; // Ensure this is needed
import 'package:image/list_siswa/modeladd.dart';

class PageAdd extends StatefulWidget {
  const PageAdd({Key? key}) : super(key: key);

  @override
  State<PageAdd> createState() => _PageRegisterEduState();
}

class _PageRegisterEduState extends State<PageAdd> {
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtTglLahir = TextEditingController();
  TextEditingController txtJenisKelamin = TextEditingController(); // Dropdown would be better
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtNoHp = TextEditingController();
  TextEditingController txtAlamat = TextEditingController();

  bool isLoading = false;

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  Future<void> registerAccount() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(
        Uri.parse('http://172.26.16.1:7070/add.php'), // Replace with your server URL
        body: {
          "nama": txtNama.text,
          "tgl_lahir": txtTglLahir.text,
          "jenis_kelamin": txtJenisKelamin.text,
          "email": txtEmail.text,
          "no_hp": txtNoHp.text,
          "alamat": txtAlamat.text,
        },
      );

      if (res.statusCode == 200) {
        // Use Modeladd instead of ModelRegister
        Modeladd modelAdd = modeladdFromJson(res.body);

        // Show success or error message based on the server response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(modelAdd.message)), // Correctly reference modelAdd
        );

        if (modelAdd.value == 1) {
          // Navigate back to PageListSiswa if registration is successful
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PageListSiswa()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false; // Ensure loading state is reset
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pegawai'),
        backgroundColor: Colors.purple,
      ),
      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Nama Input
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Nama tidak boleh kosong" : null;
                        },
                        controller: txtNama,
                        decoration: InputDecoration(
                          labelText: 'Nama',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      // Tanggal Lahir Input
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Tanggal Lahir tidak boleh kosong" : null;
                        },
                        controller: txtTglLahir,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Lahir',
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      // Jenis Kelamin Input
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Jenis Kelamin tidak boleh kosong" : null;
                        },
                        controller: txtJenisKelamin,
                        decoration: InputDecoration(
                          labelText: 'Jenis Kelamin',
                          prefixIcon: Icon(Icons.accessibility),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      // Email Input
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Email tidak boleh kosong" : null;
                        },
                        controller: txtEmail,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      // No HP Input
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "No HP tidak boleh kosong" : null;
                        },
                        controller: txtNoHp,
                        decoration: InputDecoration(
                          labelText: 'No HP',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      // Alamat Input
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Alamat tidak boleh kosong" : null;
                        },
                        controller: txtAlamat,
                        decoration: InputDecoration(
                          labelText: 'Alamat',
                          prefixIcon: Icon(Icons.home),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Register Button
                      Center(
                        child: isLoading
                            ? CircularProgressIndicator()
                            : MaterialButton(
                          minWidth: 150,
                          height: 45,
                          onPressed: () {
                            if (keyForm.currentState?.validate() == true) {
                              registerAccount();
                            }
                          },
                          child: Text('Tambah'),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
