import 'package:flutter/material.dart';
import 'package:readability/home_screen.dart';
import 'package:camera/camera.dart';

List<CameraDescription>cameras;

Future<Null> main() async {
  cameras = await availableCameras();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Readability",
        theme: new ThemeData(
          primaryColor: new Color(0xffc70039),
          accentColor: new Color(0xff900c3e),
        ),
        home: new HomeScreen(cameras));
  }
}
