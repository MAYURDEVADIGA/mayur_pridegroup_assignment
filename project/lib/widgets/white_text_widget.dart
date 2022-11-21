import 'package:flutter/material.dart';

class WhiteText extends StatelessWidget {
  const WhiteText(
      {Key? key,
      required this.title,
      this.size = 20,
      this.fontStyle = FontStyle.normal,
      this.fontWeight = FontWeight.normal})
      : super(key: key);
  final String title;
  final double size;
  final FontStyle fontStyle;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.white,
          fontStyle: fontStyle,
          fontSize: size,
          fontWeight: fontWeight),
    );
  }
}
