import 'package:flutter/material.dart';

class RecognitionScreen extends StatefulWidget {
  String filePath;
  RecognitionScreen(this.filePath);

  @override
  _RecognitionScreenState createState() => new _RecognitionScreenState();
}

class _RecognitionScreenState extends State<RecognitionScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Text(widget.filePath),
    );
  }
}
