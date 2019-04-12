import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class RecognitionScreen extends StatefulWidget {
  final File _imageFile;
  RecognitionScreen(this._imageFile);

  @override
  State<StatefulWidget> createState() {
    return _RecognitionScreenState();
  }
}

class _RecognitionScreenState extends State<RecognitionScreen> {
  Future processText() async {
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(widget._imageFile);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);
    
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          print(element.text);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          buildImage(context),
          buildTextList(["Recognised text goes here..."])
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Center(
          child: widget._imageFile == null
              ? Text('No Image')
              : FutureBuilder<Size>(
                  future: _getImageSize(
                      Image.file(widget._imageFile, fit: BoxFit.fitWidth)),
                  builder:
                      (BuildContext context, AsyncSnapshot<Size> snapshot) {
                    if (snapshot.hasData) {
                      return Image.file(widget._imageFile, fit: BoxFit.fitWidth);
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
        ),
      ),
    );
  }

  Widget buildTextList(List<String> texts) {
    processText();
    if (texts.length == 0) {
      return Expanded(
          flex: 1,
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
              return _buildTextRow(texts);
            }),
      ),
    );
  }

  Widget _buildTextRow(text) {
    return ListTile(
      title: Text(
        "$text",
      ),
      dense: true,
    );
  }

  Future<Size> _getImageSize(Image image) {
    Completer<Size> completer = Completer<Size>();
    image.image.resolve(ImageConfiguration()).addListener(
        (ImageInfo info, bool _) => completer.complete(
            Size(info.image.width.toDouble(), info.image.height.toDouble())));
    return completer.future;
  }
}
