import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image/latWisata/modelWisata.dart';
import 'package:image/latWisata/wisataPage.dart';

class DetailWisata extends StatelessWidget {
  final Datum? data;

  const DetailWisata(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default coordinates if data is null or coordinates are not provided
    final double defaultLat = -6.297950949676951;
    final double defaultLng = 106.6989246837098;
    final double latitude = data != null ? double.parse(data!.latWisata) : defaultLat;
    final double longitude = data != null ? double.parse(data!.longWisata) : defaultLng;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Wisata",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              "http://172.26.16.1/wisata/gambar/${data?.gambar}",
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text(
              data?.nama ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black87,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // Implement edit functionality here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditWisataPage(data: data),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Implement delete functionality here
                    _showDeleteConfirmationDialog(context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    data?.deskripsi ?? "",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    data?.lokasi ?? "",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    data?.profile ?? "",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              // Navigate to the new page containing only the map
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapPage(latitude, longitude),
                ),
              );
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Map",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200],
                      ),
                      child: GoogleMap(
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latitude, longitude),
                          zoom: 16,
                        ),
                        mapType: MapType.normal,
                        markers: {
                          Marker(
                            markerId: MarkerId(data?.nama ?? "default_marker"),
                            position: LatLng(latitude, longitude),
                            infoWindow: InfoWindow(
                              title: data?.nama ?? 'Unknown Location',
                              snippet: data?.lokasi ?? '',
                            ),
                          ),
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement delete functionality here
                Navigator.of(context).pop(); // Close the dialog
                _deleteData(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteData(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://172.26.16.1/wisata/getDelete.php'),
      body: {'id': data?.id.toString()}, // Assuming 'id' is the identifier
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data deleted successfully')),
      );
      Navigator.of(context).pop(); // Go back after deletion
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete data')),
      );
    }
  }
}

class MapPage extends StatelessWidget {
  final double latitude;
  final double longitude;

  const MapPage(this.latitude, this.longitude, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: MarkerId("marker_id"),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: "Location",
              snippet: "Lat: $latitude, Lng: $longitude",
            ),
          ),
        },
      ),
    );
  }
}

class EditWisataPage extends StatelessWidget {
  final Datum? data;
  final TextEditingController namaController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();
  final TextEditingController profileController = TextEditingController();
  final TextEditingController gambarController = TextEditingController();

  EditWisataPage({this.data, Key? key}) : super(key: key) {
    if (data != null) {
      namaController.text = data!.nama;
      lokasiController.text = data!.lokasi;
      deskripsiController.text = data!.deskripsi;
      latController.text = data!.latWisata;
      longController.text = data!.longWisata;
      profileController.text = data!.profile;
      gambarController.text = data!.gambar;
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
            ),
            TextField(
              controller: lokasiController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: deskripsiController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: latController,
              decoration: InputDecoration(labelText: 'Latitude'),
            ),
            TextField(
              controller: longController,
              decoration: InputDecoration(labelText: 'Longitude'),
            ),
            TextField(
              controller: profileController,
              decoration: InputDecoration(labelText: 'Profile'),
            ),
            TextField(
              controller: gambarController,
              decoration: InputDecoration(labelText: 'Image URL'),
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
        'id': data?.id.toString() ?? '',
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

        // Optionally, update local data
        if (data != null) {
          data!.nama = namaController.text;
          data!.lokasi = lokasiController.text;
          data!.profile = profileController.text;
          data!.latWisata = latController.text;
          data!.longWisata = longController.text;
          data!.gambar = gambarController.text;
          data!.deskripsi = deskripsiController.text;
        }

        // Navigate back to PageWisata
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => PageWisata()),
        );
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