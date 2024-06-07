import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image_page.dart';
import 'package:image/maps_page.dart';

class PageBeranda extends StatelessWidget {
  const PageBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Projek MI 2C'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8,),
              MaterialButton(onPressed: (){

                //code untuk pindah page
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => AksesKamera()
                ));
              },
                child: Text('Page Camera',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
                color: Colors.green,
                textColor: Colors.white,
              ),

              SizedBox(height: 8,),
              MaterialButton(onPressed: (){

                //code untuk pindah page
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => MapsFlutter()
                ));
              },
                child: Text('Page Maps',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
                color: Colors.green,
                textColor: Colors.white,
              ),


            ],
          ),
        ) ,
      ),
    );
  }
}