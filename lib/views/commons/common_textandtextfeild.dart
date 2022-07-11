import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:porelab_bubblepoint/config/common_boldtext.dart';
import 'package:porelab_bubblepoint/views/commons/common_textfeildwith_gradient.dart';
import '../../config/app_colors.dart';
import '../../config/common_text.dart';

class CommonTextWithTextfeild extends StatelessWidget {
  List<TextInputFormatter>? inputformatters;
  String text;
  String title;
  double width;
  int ? maxLength;
  TextAlign textAlign;
  Widget ? suffix;
  TextInputType ? keyboard;
  TextEditingController controller;
  String? Function(String?)? validator;
  CommonTextWithTextfeild ({this.inputformatters,this.width=double.maxFinite,this.textAlign=TextAlign.start,required this.text,required this.title,this.keyboard,this.validator,required this.controller,});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: CommonText(text: title,fontSize: 25,)),
        Expanded(
          flex: 3,
          child:
          Container(
            height: 35,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.blackColor,
                  AppColors.backGroundColor
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.whiteColor,
                  offset: Offset(-3, -0),
                  blurRadius: 1.0,
                  spreadRadius:1,
                ),
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(4, 0),
                  blurRadius: 1.0,
                  spreadRadius:1,
                ),
              ],

            ),
            child: TextFormField(
              inputFormatters: inputformatters,
              textAlign: textAlign,
              keyboardType: keyboard,
              controller: controller,
              validator: validator,
              style: TextStyle(color: AppColors.whiteColor),
              cursorColor: AppColors.whiteColor,
              decoration: InputDecoration(
                hintText: text,
                hintStyle: TextStyle(fontSize: 16,color: AppColors.whiteColor),
                counterStyle: TextStyle(color: AppColors.whiteColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius. circular(100.0),
                ),
                fillColor:Colors.transparent,
                filled: true,
                contentPadding: EdgeInsets.only(left: 14,right: 3,top: 10,bottom: 0),
                errorStyle: TextStyle(fontSize: 9,height: 0.2),
                 focusedErrorBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
                errorBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
              ),

            ),
          ),
        )
      ],
    );
  }
}
