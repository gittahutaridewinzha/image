import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image/detail_user.dart';
import 'model_user.dart';

class PageListUser extends StatefulWidget {
  const PageListUser({super.key});

  @override
  State<PageListUser> createState() => _PageListUserState();
}

class _PageListUserState extends State<PageListUser> {
  bool isLoading = false;
  List<ModelUser> listUser = [];
  List<ModelUser> filteredUsers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUsers();
    searchController.addListener(_searchUsers);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _searchUsers() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredUsers = listUser.where((user) {
        return user.firstName!.toLowerCase().contains(query) ||
            user.lastName!.toLowerCase().contains(query) ||
            user.email!.toLowerCase().contains(query);
      }).toList();
    });
  }

  // Method untuk mengambil data dari dua API
  Future getUsers() async {
    try {
      setState(() {
        isLoading = true;
      });

      // Fetch data dari link pertama
      http.Response response1 = await http.get(Uri.parse("https://reqres.in/api/users"));
      var data1 = jsonDecode(response1.body);

      // Fetch data dari link kedua
      http.Response response2 = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
      var data2 = jsonDecode(response2.body);

      setState(() {
        for (Map<String, dynamic> i in data1['data']) {
          listUser.add(ModelUser.fromJson(i));
        }
        for (Map<String, dynamic> i in data2['data']) {
          listUser.add(ModelUser.fromJson(i));
        }
        filteredUsers = listUser;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()))
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('List User'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                //labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    child: ListTile(
                      leading: Image.network(
                        filteredUsers[index].avatar ?? "",
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Icon(Icons.error, color: Colors.red);
                        },
                      ),
                      title: Text(
                        '${filteredUsers[index].firstName} ${filteredUsers[index].lastName}',
                        style: TextStyle(
                            color: Colors.cyan,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email: ${filteredUsers[index].email}"),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>PageDetailUser(user: filteredUsers[index]),
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
    );
  }
}