import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PageKab.dart';
import 'dart:convert';

import 'modelProv.dart';

class PageProvinsi extends StatefulWidget {
  const PageProvinsi({Key? key}) : super(key: key);

  @override
  State<PageProvinsi> createState() => _PageProvinsiState();
}

class _PageProvinsiState extends State<PageProvinsi> {
  TextEditingController txtCari = TextEditingController();
  List<Datum>? provinsi;
  List<Datum>? filteredProvinsi;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse('http://192.168.100.133/RS/getProv.php'));
      if (response.statusCode == 200) {
        setState(() {
          provinsi = modelProvinsiFromJson(response.body).data;
          filteredProvinsi = provinsi;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load data')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void searchProvinsi(String keyword) {
    setState(() {
      filteredProvinsi = provinsi
          ?.where((datum) => datum.namaProv.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red, // Mengubah warna latar belakang judul menjadi merah
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0), // Menambahkan padding kiri
              child: Text(
                'hai, Selamat Pagi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Mengubah warna teks menjadi putih agar kontras dengan latar belakang merah
                  fontSize: 16,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 16.0), // Menambahkan padding kiri
            //   child: Text(
            //     'Gitta Hutari',
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white, // Mengubah warna teks menjadi putih agar kontras dengan latar belakang merah
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
          ],
        ),
        titleSpacing: 0, // Menempatkan teks di sebelah kiri judul
        actions: [
          IconButton(
            onPressed: () {
              // Logout process
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: txtCari,
              onChanged: (value) {
                searchProvinsi(value);
              },
              decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Daftar Provinsi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: filteredProvinsi == null
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: filteredProvinsi?.length ?? 0,
                itemBuilder: (context, index) {
                  Datum? data = filteredProvinsi?[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListTile(
                        leading: Icon(Icons.location_city, color: Colors.red, size: 40),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Untuk memposisikan ikon di sebelah kanan
                          children: [
                            Text(
                              data?.namaProv ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 20,
                              ),
                            ),
                            Icon(Icons.arrow_forward, color: Colors.redAccent), // Menambahkan ikon panah ke samping
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PageKab(idProv: data?.idProv ?? ''),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
