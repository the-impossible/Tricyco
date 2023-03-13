import 'package:flutter/material.dart';
import 'package:tricycle/utils/constant.dart';

class DelegatedText extends StatelessWidget {
  final String text;
  final double fontSize;
  String? fontName = 'InterBold';
  Color? color = Constants.tertiaryColor;

  DelegatedText({
    required this.text,
    required this.fontSize,
    this.fontName,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        letterSpacing: 1,
        fontFamily: fontName,
      ),
    );
  }
}
