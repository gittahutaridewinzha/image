import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'modelKamar.dart';

class PageKamar extends StatefulWidget {
  final String idRs;
  final String namaRs;

  const PageKamar({Key? key, required this.idRs, required this.namaRs}) : super(key: key);

  @override
  State<PageKamar> createState() => _PageKamarState();
}

class _PageKamarState extends State<PageKamar> {
  TextEditingController txtCari = TextEditingController();
  List<Datum>? kamarList;
  List<Datum>? filteredKamarList;
  double? latRs;
  double? longRs;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse('http://192.168.100.133/RS/getKamar.php'));
      if (response.statusCode == 200) {
        ModelKamar modelKamar = modelKamarFromJson(response.body);
        setState(() {
          kamarList = modelKamar.data.where((datum) => datum.idRs == widget.idRs).toList();
          filteredKamarList = kamarList;
          if (kamarList!.isNotEmpty) {
            latRs = double.parse(kamarList![0].latRs);
            longRs = double.parse(kamarList![0].longRs);
          }
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

  void searchKamar(String keyword) {
    setState(() {
      filteredKamarList = kamarList
          ?.where((datum) => datum.namaKmr.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rooms',
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
                searchKamar(value);
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
              child: Column(
                children: [
                  Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.blueGrey,
                    child: latRs != null && longRs != null
                        ? Container(
                      height: 300,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latRs!, longRs!),
                          zoom: 14,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId(widget.idRs),
                            position: LatLng(latRs!, longRs!),
                            infoWindow: InfoWindow(title: widget.namaRs),
                          ),
                        },
                      ),
                    )
                        : Center(
                      child: Text('No data available'),
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
                    child: filteredKamarList == null
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                      itemCount: filteredKamarList?.length ?? 0,
                      itemBuilder: (context, index) {
                        Datum? data = filteredKamarList?[index];
                        return Card(
                          elevation: 2,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data?.namaKmr ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text('Jumlah Kamar: ${data?.jumlahKmr ?? '0'}'),
                                SizedBox(height: 4),
                                Text('Kamar Tersedia: ${data?.tersedia ?? '0'}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
