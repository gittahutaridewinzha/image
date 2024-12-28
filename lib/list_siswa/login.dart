import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/list_siswa/listSiswa.dart';
import 'package:image/list_siswa/model_login.dart';
import 'package:image/list_siswa/page_register.dart';
import 'package:image/session_managerlat.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  State<PageLogin> createState() => _PageLoginApiState();
}

class _PageLoginApiState extends State<PageLogin> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isLoading = false;

  late SessionLatihanManager session;

  @override
  void initState() {
    super.initState();
    session = SessionLatihanManager();
  }

  Future<ModelLogin?> loginAccount() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(
        Uri.parse('http://172.26.16.1:7070/login.php'),
        body: {
          "email": txtUsername.text,
          "password": txtPassword.text,
        },
      );

      if (res.statusCode == 200) {
        ModelLogin data = modelLoginFromJson(res.body);

        if (data.value == 1) {
          setState(() {
            isLoading = false;
            session.saveSession(
              data.value,
              data.id,
              data.email,

            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}')),
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PageListSiswa()),
                  (route) => false, // Clears the navigation stack.
            );
          });
        } else {
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}')),
            );
          });
        }
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed, please try again.')),
          );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Form Login'),
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
                      // Image.asset(
                      //   'gambar/login3.png',
                      //   fit: BoxFit.contain,
                      //   height: 250,
                      //   width: 250,
                      // ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Tidak boleh kosong" : null;
                        },
                        controller: txtUsername,
                        decoration: InputDecoration(
                          labelText: 'Input Email',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Tidak boleh kosong" : null;
                        },
                        controller: txtPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Input Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                  Center(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : MaterialButton(
                      minWidth: 150,
                      height: 45,
                      onPressed: () {
                        if (keyForm.currentState?.validate() == true) {
                          loginAccount();
                        }
                      },
                      child: Text('Login'),
                      color: Colors.purple,
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15),
                  // Sign In Button
                  Center(
                    child: MaterialButton(
                      minWidth: 150,
                      height: 45,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageRegisterEdu(),
                          ),
                        );
                      },
                      child: Text('Sign in'),
                      color: Colors.purple,
                      textColor: Colors.white,
                    ),
                  )
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
