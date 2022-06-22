

import 'package:flutter/material.dart';
import 'app_colors.dart';

class CommonText extends StatelessWidget {
  String text;
  double fontSize;
  double height;
  FontWeight fontWeight;
  Color color;
  TextAlign? textAlign;
  int? maxLines;
  TextOverflow? textOverFlow;

  CommonText(
      {required this.text,
        this.fontSize = 15,
        this.fontWeight = FontWeight.normal,
        this.color = AppColors.whiteColor,
        this.textAlign,
        this.maxLines,
        this.textOverFlow,
        this.height = 1.1});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverFlow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        color: color,
      ),
    );
  }
}
