import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/latihan_RS/pageKamar.dart';
import 'dart:convert';

import 'modelRs.dart';

class PageRs extends StatefulWidget {
  final String idKabupaten;

  const PageRs({Key? key, required this.idKabupaten}) : super(key: key);

  @override
  State<PageRs> createState() => _PageRsState();
}

class _PageRsState extends State<PageRs> {
  TextEditingController txtCari = TextEditingController();
  List<Datum>? rsList;
  List<Datum>? filteredRsList;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse('http://192.168.100.133/RS/getRs.php'));
      if (response.statusCode == 200) {
        List<Datum> allRs = modelRsFromJson(response.body).data;
        setState(() {
          rsList = allRs.where((datum) => datum.idKabupaten == widget.idKabupaten).toList();
          filteredRsList = rsList;
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

  void searchRs(String keyword) {
    setState(() {
      filteredRsList = rsList
          ?.where((datum) => datum.namaRs.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hospitals',
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
                searchRs(value);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'COVID-19',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'NON COVID-19',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: filteredRsList == null
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: filteredRsList?.length ?? 0,
                itemBuilder: (context, index) {
                  Datum? data = filteredRsList?[index];
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: data?.gambar != null && data!.gambar.isNotEmpty
                          ? Image.network(
                        'http://192.168.100.133/RS/gambar/${data.gambar}',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                          : Icon(Icons.local_hospital, size: 50, color: Colors.blueAccent),
                      title: Text(
                        data?.namaRs ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Alamat: ${data?.alamat ?? ''}'),
                          Text('Telp: ${data?.noTelp ?? ''}'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PageKamar(
                                idRs: data?.idRs ?? '',
                                namaRs: data?.namaRs ?? ''),
                          ),
                        );
                      },
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
