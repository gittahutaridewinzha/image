import 'package:flutter/material.dart';
import 'model_user.dart';

class PageDetailUser extends StatelessWidget {
  final ModelUser user;

  const PageDetailUser({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                user.avatar ?? "",
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'First Name: ${user.firstName}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Last Name: ${user.lastName}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Email: ${user.email}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}