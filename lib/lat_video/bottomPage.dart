
import 'package:flutter/material.dart';

import 'package:image/lat_video/videoPage.dart';

class PageBottom extends StatefulWidget {
  const PageBottom({Key? key}) : super(key: key);

  @override
  State<PageBottom> createState() => _PageBottomNavigationBarState();
}

class _PageBottomNavigationBarState extends State<PageBottom> with SingleTickerProviderStateMixin {
  late TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: [
            VideoListPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        child: SingleChildScrollView(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              controller: tabController,
              tabs: [
                Tab(
                  text: "Search",
                  icon: Icon(Icons.search),
                ),
                Tab(
                  text: "Favorites",
                  icon: Icon(Icons.favorite),
                ),
                Tab(
                  text: "Video",
                  icon: Icon(Icons.video_camera_back_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}