
import 'package:flutter/material.dart';
import 'package:image/list_berita/model_berita.dart';

class PageDetailBerita extends StatelessWidget {

  final Datum listberita;

  const PageDetailBerita({super.key, required this.listberita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${listberita.judul}',  style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.purple,
        ),

        body: SingleChildScrollView(
            padding: const EdgeInsets.all(10,),
            child : Column(
                crossAxisAlignment : CrossAxisAlignment.start,
                children:[
                  // ClipRRect(
                  //   borderRadius : BorderRadius.circular(10),
                  //   child : Image.network('http://192.168.1.3:8080/server_university/images/${university?.univImage}',
                  //     height: 125,
                  //     width : double.infinity,
                  //     fit: BoxFit.fill,
                  //   ),
                  // ),
                  SizedBox(height : 10),
                  Text('${listberita.judul}'),
                  SizedBox(height : 10),
                  Text('${listberita.tglBerita}'),
                  SizedBox(height : 10),
                  Text('${listberita.isiBerita}'),
                  SizedBox(height : 10),

                ]
            )

        )
    );
  }
}