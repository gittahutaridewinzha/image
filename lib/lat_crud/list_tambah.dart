import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image/lat_crud/model_add.dart';

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _firstNameError;
  String? _lastNameError;
  String? _noHpError;
  String? _emailError;

  Future<void> _submitData() async {
    // Reset previous errors
    setState(() {
      _firstNameError = null;
      _lastNameError = null;
      _noHpError = null;
      _emailError = null;
    });

    if (_formKey.currentState!.validate()) {
      final String firstName = _firstNameController.text;
      final String lastName = _lastNameController.text;
      final String noHp = _noHpController.text;
      final String email = _emailController.text;

      final response = await http.post(
        Uri.parse('http://192.168.100.133/DBDATA/addData.php'),
        body: {
          'first_name': firstName,
          'last_name': lastName,
          'noHp': noHp,
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        final result = modelAddFromJson(response.body);
        if (result.value == 1) {
          // Berhasil menambahkan data
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.green,
          ));
          // Kembali ke halaman sebelumnya (PageList)
          Navigator.pop(context);
        } else {
          // Gagal menambahkan data
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        // Error dari server
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Server error"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  errorText: _firstNameError,
                ),
                validator: (val) {
                  return val!.isEmpty ? "Field can't be empty" : null;
                },
                onChanged: (_) {
                  setState(() {
                    _firstNameError = null; // Hapus pesan kesalahan saat pengguna mulai mengisi
                  });
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  errorText: _lastNameError,
                ),
                validator: (val) {
                  return val!.isEmpty ? "Field can't be empty" : null;
                },
                onChanged: (_) {
                  setState(() {
                    _lastNameError = null; // Hapus pesan kesalahan saat pengguna mulai mengisi
                  });
                },
              ),
              TextFormField(
                controller: _noHpController,
                decoration: InputDecoration(
                  labelText: 'No Handphone',
                  errorText: _noHpError,
                ),
                validator: (val) {
                  return val!.isEmpty ? "Field can't be empty" : null;
                },
                onChanged: (_) {
                  setState(() {
                    _noHpError = null; // Hapus pesan kesalahan saat pengguna mulai mengisi
                  });
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: _emailError,
                ),
                validator: (val) {
                  return val!.isEmpty ? "Field can't be empty" : null;
                },
                onChanged: (_) {
                  setState(() {
                    _emailError = null; // Hapus pesan kesalahan saat pengguna mulai mengisi
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
