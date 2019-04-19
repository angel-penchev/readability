import 'package:flutter/material.dart';

BoxDecoration uiScreenDecoration(int topColor, int bottomColor) {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(topColor),
        Color(bottomColor),
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      tileMode: TileMode.clamp,
    ),
  );
}

Widget uiScreenPadding() {
  return Padding(
    padding:
        const EdgeInsets.only(left: 12.0, right: 12.0, top: 30.0, bottom: 30.0),
  );
}

Widget uiScreenHeading(String headingText) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          headingText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 46.0,
            fontFamily: "Calibre-Semibold",
            letterSpacing: 1.0,
          ),
        ),
      ],
    ),
  );
}

Widget uiCard(double cardAspectRatio, content) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(3.0, 6.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: cardAspectRatio,
        child: Stack(
          fit: StackFit.expand,
          children: content,
        ),
      ),
    ),
  );
}

Widget uiCardHeading(String headingText) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Text(
            headingText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontFamily: "SF-Pro-Text-Regular",
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    ),
  );
}
