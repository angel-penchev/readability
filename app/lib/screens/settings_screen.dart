import 'package:flutter/material.dart';
import 'package:readability/logic/ui_elements.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: uiScreenDecoration(0xFF2d3447, 0xFF1b1e44),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            uiScreenPadding(),
            uiScreenHeading("Settings"),
          ],
        ),
      ),
    );
  }
}
