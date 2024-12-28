// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:audioplayers/audioplayers.dart';
// import 'model_audio.dart';
//
// class PageFavorite extends StatefulWidget {
//   const PageFavorite({Key? key});
//
//   @override
//   State<PageFavorite> createState() => _PageAudioState();
// }
//
// class _PageAudioState extends State<PageFavorite> {
//   TextEditingController txtCari = TextEditingController();
//   List<Datum>? audio;
//   List<Datum>? filteredAudios;
//   final AudioPlayer _audioPlayer = AudioPlayer();
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     try {
//       http.Response response = await http.get(
//           Uri.parse('http://192.168.100.133/AUDIO/getAudio.php'));
//       setState(() {
//         audio = modelAudioFromJson(response.body).data;
//         filteredAudios = audio;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.toString())),
//       );
//     }
//   }
//
//   void searchAudio(String keyword) {
//     setState(() {
//       filteredAudios = audio
//           ?.where((datum) =>
//           datum.audio.toLowerCase().contains(keyword.toLowerCase()))
//           .toList();
//     });
//   }
//
//   void playAudio(String url) async {
//     await _audioPlayer.play(url);
//   }
//
//   void stopAudio() async {
//     await _audioPlayer.stop();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // title: Text(
//         //   // 'Lagu Favorit',
//         //   // style: TextStyle(
//         //   //   fontWeight: FontWeight.bold,
//         //   //   color: Colors.white,
//         //   // ),
//         // ),
//         centerTitle: true,
//         backgroundColor: Colors.deepOrange[900],
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.white),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Proses logout
//             },
//             icon: Icon(Icons.exit_to_app),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: txtCari,
//               onChanged: (value) {
//                 searchAudio(value);
//               },
//               decoration: InputDecoration(
//                 hintText: "Cari",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//                 prefixIcon: Icon(Icons.search, color: Colors.deepOrange[900]),
//               ),
//             ),
//             // SizedBox(height: 20),
//             // Center(
//             //   child: Text(
//             //     'Albums',
//             //     style: TextStyle(
//             //       fontSize: 18,
//             //       fontWeight: FontWeight.bold,
//             //       color: Colors.black26,
//             //     ),
//             //   ),
//             // ),
//             // SizedBox(height: 10),
//             // SingleChildScrollView(
//             //   scrollDirection: Axis.horizontal,
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.center,
//             //     children: [
//             //       albumCard('https://i.pinimg.com/564x/7b/94/84/7b9484da7a857cb15cb86c6003277986.jpg', 'Bathing Beach'),
//             //       albumCard('https://i.pinimg.com/564x/0d/94/0f/0d940f9291909a8ba4115d3e057c3e0c.jpg', 'Wasteland, Baby!'),
//             //       albumCard('https://i.pinimg.com/564x/bf/d6/5a/bfd65a23e60fb8139deb935d4c341799.jpg', 'Cleopatra'),
//             //     ],
//             //   ),
//             // ),
//             SizedBox(height: 20),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Favoite',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredAudios?.length ?? 0,
//                 itemBuilder: (context, index) {
//                   Datum? audio = filteredAudios?[index];
//                   return ListTile(
//                     contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                     leading: audio?.gambar != null
//                         ? Image.network(
//                       'http://192.168.100.133/AUDIO/gambar/${audio?.gambar}',
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.cover,
//                     )
//                         : Container(
//                       width: 50,
//                       height: 50,
//                       color: Colors.grey,
//                       child: Icon(Icons.image, color: Colors.white),
//                     ),
//                     title: Text(
//                       audio?.audio ?? "",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     subtitle: Text(
//                       audio?.artis ?? "",
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                     trailing: SizedBox(
//                       width: 120, // Tentukan lebar tetap untuk Row
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.play_arrow),
//                             onPressed: () {
//                               if (audio != null) {
//                                 playAudio(
//                                     'http://192.168.100.133/AUDIO/audio/${audio.audio}');
//                               }
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.stop),
//                             onPressed: () {
//                               stopAudio();
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.favorite),
//                             onPressed: () {
//                               // Tambahkan ke favorit
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Widget albumCard(String imageUrl, String title) {
//   //   return Padding(
//   //     padding: EdgeInsets.symmetric(horizontal: 5),
//   //     child: Card(
//   //       color: Colors.white70,
//   //       elevation: 2,
//   //       child: Padding(
//   //         padding: EdgeInsets.all(10),
//   //         child: Column(
//   //           children: [
//   //             Container(
//   //               width: 60,
//   //               height: 60,
//   //               color: Colors.white70,
//   //               child: Image.network(
//   //                 imageUrl,
//   //                 fit: BoxFit.cover,
//   //               ),
//   //             ),
//   //             SizedBox(height: 10),
//   //             Text(
//   //               title,
//   //               style: TextStyle(
//   //                 fontWeight: FontWeight.bold,
//   //                 color: Colors.black26,
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
// }
