import 'package:flutter/material.dart';
import 'package:image/db_microservice/home_page.dart';
import 'package:image/image_page.dart';
import 'package:image/latWisata/wisataPage.dart';
import 'package:image/lat_bola/page_sepakbola.dart';
import 'package:image/lat_crud/list_page.dart';
import 'package:image/lat_delete/siswaPage.dart';
import 'package:image/lat_note/pageNote.dart';
import 'package:image/lat_video/bottomPage.dart';
import 'package:image/latihan_RS/Page_Prov.dart';
import 'package:image/latihan_audio/bottom_page.dart';
import 'package:image/latihan_audio/page_splasj.dart';
import 'package:image/latihan_audio/search_page.dart';
import 'package:image/latihan_listPegawai.dart';
import 'package:image/latihan_maps/latihan_detailMaps.dart';
import 'package:image/latihan_maps/page_maps.dart';
import 'package:image/list_berita/berita.dart';
import 'package:image/list_siswa/login.dart';
import 'package:image/maps_page.dart';
import 'package:image/mediaplayer/pagemedia.dart';
import 'package:image/page_beranda.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

