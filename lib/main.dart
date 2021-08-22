// import 'dart:io';

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wallpaper/home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Myhome(),
    );
  }
}

class Myhome extends StatefulWidget {
  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 7),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context1) => Home())));
  }

  @override
  Widget build(BuildContext context1) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 200.0),
          Image.asset(
            'assets/icon.png',
            height: 200.0,
          ),
          SizedBox(height: 2.0),
          SpinKitThreeBounce(
            color: Colors.deepOrange,
            size: 20,
          ),
          SizedBox(height: 2.0),
          Container(
            child: Text(
              "@Team_Incognito",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: 'overpass',
              ),
            ),
            margin: EdgeInsets.only(top: 200),
          )
        ],
      ),
    );
  }
}
