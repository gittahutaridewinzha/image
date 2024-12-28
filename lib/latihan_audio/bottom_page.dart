// import 'package:flutter/material.dart';
// import 'package:image/latihan_audio/page_favorite.dart';
// import 'package:image/latihan_audio/search_page.dart';
//
// class PageBottomNavigationBar extends StatefulWidget {
//   const PageBottomNavigationBar({super.key});
//
//   @override
//   State<PageBottomNavigationBar> createState() =>
//       _PageBottomNavigationBarState();
// }
//
// class _PageBottomNavigationBarState extends State<PageBottomNavigationBar>
//     with SingleTickerProviderStateMixin {
//   TabController? tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: TabBarView(
//         controller: tabController,
//         children: const [
//           PageAudio(),
//           PageFavorite(),
//           Center(child: Text("search")),
//           Center(child: Text("favorite")),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: tabController?.index ?? 0,
//         onTap: (index) {
//           setState(() {
//             tabController?.index = index;
//           });
//         },
//         selectedItemColor: Colors.deepOrange, // Warna ikon saat dipilih
//         unselectedItemColor: Colors.deepOrange, // Warna ikon saat tidak dipilih
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: "Search",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: "Favorite",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.music_note),
//             label: "Music",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }