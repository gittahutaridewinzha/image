import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image/latWisata/modelWisata.dart';

class EditWisataPage extends StatefulWidget {
  final Datum? data;

  EditWisataPage({this.data, Key? key}) : super(key: key);

  @override
  _EditWisataPageState createState() => _EditWisataPageState();
}

class _EditWisataPageState extends State<EditWisataPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();
  final TextEditingController profileController = TextEditingController();
  final TextEditingController gambarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      namaController.text = widget.data!.nama ?? '';
      lokasiController.text = widget.data!.lokasi ?? '';
      deskripsiController.text = widget.data!.deskripsi ?? '';
      latController.text = widget.data!.latWisata ?? '';
      longController.text = widget.data!.longWisata ?? '';
      profileController.text = widget.data!.profile ?? '';
      gambarController.text = widget.data!.gambar ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Wisata'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                widget.data!.nama = value; // Update widget.data when value changes
              },
            ),
            TextField(
              controller: lokasiController,
              decoration: InputDecoration(labelText: 'Location'),
              onChanged: (value) {
                widget.data!.lokasi = value; // Update widget.data when value changes
              },
            ),
            TextField(
              controller: deskripsiController,
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                widget.data!.deskripsi = value; // Update widget.data when value changes
              },
            ),
            TextField(
              controller: latController,
              decoration: InputDecoration(labelText: 'Latitude'),
              onChanged: (value) {
                widget.data!.latWisata = value; // Update widget.data when value changes
              },
            ),
            TextField(
              controller: longController,
              decoration: InputDecoration(labelText: 'Longitude'),
              onChanged: (value) {
                widget.data!.longWisata = value; // Update widget.data when value changes
              },
            ),
            TextField(
              controller: profileController,
              decoration: InputDecoration(labelText: 'Profile'),
              onChanged: (value) {
                widget.data!.profile = value; // Update widget.data when value changes
              },
            ),
            TextField(
              controller: gambarController,
              decoration: InputDecoration(labelText: 'Image URL'),
              onChanged: (value) {
                widget.data!.gambar = value; // Update widget.data when value changes
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveData(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveData(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://172.26.16.1/wisata/getUpdate.php'),
      body: {
        'id': widget.data?.id.toString() ?? '',
        'nama': namaController.text,
        'lokasi': lokasiController.text,
        'profile': profileController.text,
        'lat_wisata': latController.text,
        'long_wisata': longController.text,
        'gambar': gambarController.text,
        'deskripsi': deskripsiController.text,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['is_success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data saved successfully')),
        );

        // Optionally, navigate back or update state as needed
        Navigator.of(context).pop(); // Close the edit page
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save data')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to communicate with server')),
      );
    }
  }
}
