import 'package:flutter/material.dart';
import 'package:readability/screens/scan_screen.dart';
import 'package:readability/screens/open_screen.dart';
import 'package:readability/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  var cameras;
  HomeScreen(this.cameras);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        children: <Widget>[
          SettingsScreen(),
          ScanScreen(widget.cameras),
          OpenScreen(),
        ],
      ),
    );
  }
}
