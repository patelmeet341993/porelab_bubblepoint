import 'package:flutter/material.dart';
import 'app_colors.dart';

class CommonBoldText extends StatelessWidget {
  String text;
  double fontSize;
  FontWeight fontWeight;
  Color color;
  TextAlign? textAlign;
  int? maxLines;
  TextOverflow? overflow;
  TextDecoration decoration;
  CommonBoldText({
    required this.text,
    this.fontSize=16,
    this.fontWeight=FontWeight.w800,
    this.color=AppColors.whiteColor,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration=TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize:fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
      ),
    );
  }
}
