import 'package:flutter/material.dart';
import 'modelList.dart'; // Pastikan Anda mengimpor modelList yang berisi definisi Datum dan ModelList

class Detail extends StatelessWidget {
  final Datum data;

  const Detail({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail User"),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text(
              '${data.firstName} ${data.lastName}',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            subtitle: Text('ID: ${data.id}'),
            trailing: Icon(
              Icons.account_circle,
              color: Colors.blue,
              size: 50,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Email: ${data.email}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 8.0),
          Text(
            'Phone: ${data.noHp}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
