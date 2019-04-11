import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class RecognitionScreen extends StatefulWidget {
  File imageFile;
  RecognitionScreen(this.imageFile);

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
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Image.file(widget.imageFile),
          ),
          Flexible(
            flex: 1,
            child: Text("_recognisedText"),
          ),
        ],
      ),
    );
  }
}
