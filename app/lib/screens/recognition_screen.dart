import 'dart:io';
//import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:readability/logic/ui_elements.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class RecognitionScreen extends StatefulWidget {
  final File _imageFile;
  final String _recognisedText;
  RecognitionScreen(this._imageFile, this._recognisedText);


  FlutterBluetoothSerial serial = FlutterBluetoothSerial.instance;
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice _device;

  void initState(){

  }

  @override
  State<StatefulWidget> createState() {
    return _RecognitionScreenState();
  }
}

class _RecognitionScreenState extends State<RecognitionScreen> {
  /*Future processText() async {
    FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(widget._imageFile);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          print(element.text);
        }
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: uiScreenDecoration(0xFF1b1e44, 0xFF2d3447),
      child: Column(
        children: <Widget>[
          uiScreenPadding(),
          buildImage(context),
          buildTextList(
            ["Recognised text goes here..."],
          ),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return Expanded(
      flex: 1,
      child: uiCard(
        16/9,
        <Widget>[Image.file(widget._imageFile)],
      ),
    );
  }

  Widget buildTextList(List<String> texts) {
    if (texts.length == 0) {
      return Expanded(
          flex: 2,
          child: Center(
            child: Text('No text detected',
                style: Theme.of(context).textTheme.subhead),
          ));
    }
    return Expanded(
      flex: 1,
      child: Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(1.0),
            itemCount: texts.length,
            itemBuilder: (context, i) {
              return uiScreenHeading("text");
            }),
      ),
    );
  }
}
