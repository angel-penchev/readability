import 'package:flutter/material.dart';
import 'package:readability/screens/home_screen.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
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

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');
