import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/latihan_RS/PageRS.dart';
import 'dart:convert';

import 'modelKab.dart';

class PageKab extends StatefulWidget {
  final String idProv;

  const PageKab({Key? key, required this.idProv}) : super(key: key);

  @override
  State<PageKab> createState() => _PageKabState();
}

class _PageKabState extends State<PageKab> {
  TextEditingController txtCari = TextEditingController();
  List<Datum>? kabupaten;
  List<Datum>? filteredKabupaten;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse('http://192.168.100.133/RS/getKab.php'));
      if (response.statusCode == 200) {
        List<Datum> allKabupaten = modelKabFromJson(response.body).data;
        setState(() {
          kabupaten = allKabupaten.where((datum) => datum.idProv == widget.idProv).toList();
          filteredKabupaten = kabupaten;
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

  void searchKabupaten(String keyword) {
    setState(() {
      filteredKabupaten = kabupaten
          ?.where((datum) => datum.namaKab.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kabupaten',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: txtCari,
              onChanged: (value) {
                searchKabupaten(value);
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
            SizedBox(height: 20),
            Expanded(
              child: filteredKabupaten == null
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: filteredKabupaten?.length ?? 0,
                itemBuilder: (context, index) {
                  Datum? data = filteredKabupaten?[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListTile(
                        leading: Icon(Icons.location_on, color: Colors.blueAccent, size: 40),
                        title: Text(
                          data?.namaKab ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PageRs(idKabupaten: data?.idKabupaten ?? ''),
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
