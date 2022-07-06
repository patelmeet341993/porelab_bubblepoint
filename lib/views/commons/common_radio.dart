import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
class CommonRadio extends StatefulWidget {
String text1;
String text2;
String text3;


String ? valued;
void Function(String?)? onChanged;
CommonRadio({required this.onChanged,required this.valued,required this.text1,required this.text2,required this.text3});
  @override
  State<CommonRadio> createState() => _CommonRadioState();
}

class _CommonRadioState extends State<CommonRadio> {


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            leading: Radio(
              activeColor: AppColors.lightBlueColor,
                value: "Hydrophilic",
                groupValue: widget.valued,
                onChanged:widget.onChanged),
             title:CommonText(text:widget.text1) ,
          ),
        ),
        Expanded(
          child: ListTile(
            leading: Radio(
              activeColor: AppColors.lightBlueColor,
              value: "Hydrophobic",
              groupValue: widget.valued,
              onChanged:widget.onChanged),
            title:CommonText(text: widget.text2) ,
          ),
        ),
        Expanded(
          child: ListTile(
            leading: Radio(
              activeColor: AppColors.lightBlueColor,
              value: "Unknown",
              groupValue: widget.valued,
              onChanged:widget.onChanged
            ),
            title:CommonText(text:widget.text3) ,
          ),
        )
      ],
    );
  }
}
