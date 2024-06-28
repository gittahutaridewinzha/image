import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image/lat_delete/modelSiswa.dart';

class PageListSiswa extends StatefulWidget {
  const PageListSiswa({Key? key}) : super(key: key);

  @override
  State<PageListSiswa> createState() => _PageListState();
}

class _PageListState extends State<PageListSiswa> {
  TextEditingController txtCari = TextEditingController();
  List<Datum>? users;
  List<Datum>? filteredUsers;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      http.Response response = await http.get(
          Uri.parse('http://10.127.198.236/siswa/getList.php'));
      setState(() {
        users = modelSiswaFromJson(response.body).data;
        filteredUsers = users;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void searchUser(String keyword) {
    setState(() {
      filteredUsers = users
          ?.where((datum) =>
          datum.nama.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  Future<void> deleteUser(String id) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.127.198.236/siswa/getDelete.php'),
        body: {
          'id': id,
        },
      );
      if (response.statusCode == 200) {
        fetchData();
      } else {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user: $e')),
      );
    }
  }

  void confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('yakin ingin hapus data?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                deleteUser(id);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: txtCari,
              onChanged: (value) {
                searchUser(value);
              },
              decoration: InputDecoration(
                hintText: "search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredUsers?.length ?? 0,
                itemBuilder: (context, index) {
                  Datum? data = filteredUsers?[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data?.nama ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Sekolah: ${data?.sekolah ?? ''}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Email: ${data?.email ?? ''}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              confirmDelete(data!.id);
                            },
                          ),
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
    );
  }
}