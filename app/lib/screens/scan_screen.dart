import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:readability/screens/recognition_screen.dart';
import 'package:readability/logic/ui_elements.dart';
import 'package:readability/logic/json_prashing.dart';

class ScanScreen extends StatefulWidget {
  var cameras;
  ScanScreen(this.cameras);

  @override
  _ScanScreenState createState() {
    return _ScanScreenState();
  }
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class _ScanScreenState extends State<ScanScreen> {
  CameraController controller;
  String imagePath;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  File jsonFile;
  Directory dir;
  String jsonName = "captured.json";
  bool jsonExists = false;
  Map<String, String> jsonContent;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.high,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: uiScreenDecoration(0xFF1b1e44, 0xFF2d3447),
      child: Column(
        children: <Widget>[
          uiScreenPadding(),
          uiScreenHeading("Scan"),
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Initializing camera...',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return IconButton(
        iconSize: 1000,
        icon: uiCard(
          controller.value.aspectRatio,
          <Widget>[
            CameraPreview(controller),
            uiCardHeading("Tap to capture"),
          ],
        ),
        onPressed: () {
          if (controller != null && controller.value.isInitialized) {
            onTakePictureButtonPressed();
          }
        },
      );
    }
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();



  showOverlay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
              top: 40.0,
              right: 10.0,
              child: CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.red,
                child: Text("1"),
              ),
            ));
    overlayState.insert(overlayEntry);

    await Future.delayed(Duration(seconds: 2));

    overlayEntry.remove();
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) {
          // TODO: Add Firebase recognition and JSON phrasing here

          if(jsonFile == null) {
            jsonFile = jsonCreate(dir, jsonName);
          }
          jsonWrite(jsonFile, "imagePath", "$imagePath");


          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecognitionScreen(File('$imagePath')),
            ),
          );
        }
      }
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      return null;
    }

    final String currentTimestamp = timestamp();
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/pictures';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/$currentTimestamp.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
  }
}
