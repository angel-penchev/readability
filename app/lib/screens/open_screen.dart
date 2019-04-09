import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class OpenScreen extends StatefulWidget {
  createState() => _OpenScreen();
}

class _OpenScreen extends State<OpenScreen> {
  final PageController ctrl = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: ctrl,
        children: [
          FutureBuilder(
            future: _getLocalFile("Pictures/1554055531209.jpg"),
            builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
              return snapshot.data != null
                  ? new Image.file(snapshot.data)
                  : new Container();
            },
          ),
          FutureBuilder(
            future: _getLocalFile("Pictures/1554059005529.jpg"),
            builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
              return snapshot.data != null
                  ? new Image.file(snapshot.data)
                  : new Container();
            },
          ),
        ],
      ),
    );
  }

  Future<File> _getLocalFile(String filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File f = new File('$dir/$filename');
    return f;
  }
}
