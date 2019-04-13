import 'package:flutter/material.dart';
import 'dart:math';
import 'package:readability/ui_elements.dart';

class OpenScreen extends StatefulWidget {
  createState() => _OpenScreen();
}

var cardAspectRatio = 10.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class CustomIcons {
  static const IconData menu = IconData(0xe900, fontFamily: "CustomIcons");
  static const IconData option = IconData(0xe902, fontFamily: "CustomIcons");
}

List<String> images = [
  "assets/img/image_04.jpg",
  "assets/img/image_03.jpg",
  "assets/img/image_02.jpg",
  "assets/img/image_01.png",
];

List<String> title = [
  "Sun 14 Mar - 1:32 PM",
  "Sat 13 Mar - 11:29 AM",
  "Sat 13 Mar - 11:02 PM",
  "Fri 12 Mar - 10:32 PM",
];

class _OpenScreen extends State<OpenScreen> {
  var currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Container(
      decoration: uiScreenDecoration(0xFF2d3447, 0xFF1b1e44),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            uiScreenPadding(),
            uiScreenHeading("Open"),
            Stack(
              children: <Widget>[
                CardScrollWidget(currentPage),
                Positioned.fill(
                  child: PageView.builder(
                    itemCount: images.length,
                    controller: controller,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Container();
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: uiCard(
              cardAspectRatio,
              <Widget>[
                Image.asset(images[i], fit: BoxFit.cover),
                uiCardHeading(title[i]),
              ],
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
