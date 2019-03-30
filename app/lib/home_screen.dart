import 'package:flutter/material.dart';
import 'package:readability/screens/scan_screen.dart';
import 'package:readability/screens/open_screen.dart';

class HomeScreen extends StatefulWidget {
  var cameras;
  HomeScreen(this.cameras);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 1, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Readability"),
        bottom: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.camera_alt)),
            new Tab(icon: new Icon(Icons.pages)),
          ],
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new ScanScreen(widget.cameras),
          new OpenScreen(),
        ],
      ),
    );
  }
}
