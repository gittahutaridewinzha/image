import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image/list_siswa/model_register.dart';


class PageRegisterEdu extends StatefulWidget {
  const PageRegisterEdu({Key? key}) : super(key: key);

  @override
  State<PageRegisterEdu> createState() => _PageRegisterEduState();
}

class _PageRegisterEduState extends State<PageRegisterEdu> {
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtTglLahir = TextEditingController();
  TextEditingController txtJenisKelamin = TextEditingController(); // This could be a dropdown or text input
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtNoHp = TextEditingController();
  TextEditingController txtAlamat = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isLoading = false;

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  Future<void> registerAccount() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(
        Uri.parse('http://172.26.16.1:7070/register.php'), // Replace with your server URL
        body: {
          "nama": txtNama.text,
          "tgl_lahir": txtTglLahir.text,
          "jenis_kelamin": txtJenisKelamin.text, // Assuming this is a string input
          "email": txtEmail.text,
          "no_hp": txtNoHp.text,
          "alamat": txtAlamat.text,
          "password": txtPassword.text,
        },
      );

      if (res.statusCode == 200) {
        ModelRegister modelRegister = modelRegisterFromJson(res.body);

        // Show success or error message based on the server response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(modelRegister.message)),
        );

        if (modelRegister.value == 1) {
          // Optionally, navigate to another page if registration is successful
          Navigator.pop(context); // Close the registration page
        }

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Failed')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                      SizedBox(height: 8),
                      // Password Input
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Password tidak boleh kosong" : null;
                        },
                        controller: txtPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
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
                          child: Text('Register'),
                          color: Colors.purple,
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
