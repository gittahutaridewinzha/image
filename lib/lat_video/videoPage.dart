import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image/lat_video/detailPage.dart';
import 'package:image/lat_video/modelVideo.dart';

class VideoListPage extends StatefulWidget {
  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  late Future<ModelVideo> futureModelVideo;

  @override
  void initState() {
    super.initState();
    futureModelVideo = fetchDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterTube'),
        backgroundColor: Colors.grey,
      ),
      body: FutureBuilder<ModelVideo>(
        future: futureModelVideo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.data.length,
              itemBuilder: (context, index) {
                Datum video = snapshot.data!.data[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  leading: Image.network(
                    'http://192.168.100.133/DBVIDEO/thumbnail/' + video.thumbnail, // Menggunakan URL thumbnail
                    width: 100,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    video.judul,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerPage(videoData: video),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      backgroundColor: Colors.black12,
    );
  }

  Future<ModelVideo> fetchDataFromDatabase() async {
    final response = await http.get(Uri.parse('http://192.168.100.133/DBVIDEO/getVideo.php'));

    if (response.statusCode == 200) {
      return ModelVideo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load video data');
    }
  }
}
