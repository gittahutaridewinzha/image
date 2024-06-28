import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/lat_crud/detail.dart';
import 'package:image/lat_crud/editPage.dart';
import 'package:image/lat_crud/list_tambah.dart';
import 'package:image/lat_crud/modelList.dart';
import 'modelEdit.dart';

class PageList extends StatefulWidget {
  const PageList({Key? key}) : super(key: key);

  @override
  State<PageList> createState() => _PageListState();
}

class _PageListState extends State<PageList> {
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
          Uri.parse('http://192.168.100.133/DBDATA/getListData.php'));
      setState(() {
        users = modelListFromJson(response.body).data;
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
          datum.firstName.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  Future<void> deleteUser(String id) async {
    try {
      await http.get(
        Uri.parse('http://192.168.100.133/DBDATA/getDelete.php?id=$id'),
      );
      // Update the state to reflect the deleted data
      fetchData();
    } catch (e) {
      // Show error message if deletion fails
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
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this user?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
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

  void navigateToEdit(Datum user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageEditPegawai(data: user),
      ),
    ).then((updated) {
      if (updated != null && updated == true) {
        setState(() {
          int index = users!.indexWhere((element) => element.id == user.id);
          if (index != -1) {
            users![index] = user; // This assumes the user object is already updated
            filteredUsers = List.from(users!); // Reassign filteredUsers to trigger rebuild
          }
        });
      }
    });
  }

  void navigateToAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddDataPage(),
      ),
    ).then((_) => fetchData());
  }

  void navigateToDetail(Datum user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail(data: user),
      ),
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
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to profile page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => PageBottom(initialIndex: 1)),
              // );
            },
            icon: Icon(Icons.account_circle),
          ),
          IconButton(
            onPressed: () {
              // Logout process
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PageLoginEdu()),
              // );
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
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
                  return GestureDetector(
                    onTap: () {
                      navigateToDetail(data!); // Tambahkan ini untuk navigasi ke detail
                    },
                    child: Card(
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
                                    '${data?.firstName} ${data?.lastName}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Email: ${data?.email}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Phone: ${data?.noHp}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                navigateToEdit(data!);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                confirmDelete(data!.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAdd,
        child: Icon(Icons.add),
      ),
    );
  }
}
