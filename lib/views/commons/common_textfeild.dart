import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';

import '../../config/app_colors.dart';


class CustomTextFeild extends StatelessWidget {
  String text;
  int ? maxLength;
  double width;
  Widget ? suffix;
  bool isobsure;
  TextInputType ? keyboard;
  TextEditingController controller;
  String? Function(String?)? validator;
  int? maxLines = 1;
  int? minLines;
  double? height = 35;
  double horizontalPadding = 30;
  double verticalPadding=0.0;
  double borderRadius = 100.0;

  CustomTextFeild({
    this.width=double.maxFinite,
    this.maxLines=1,this.minLines,
    this.horizontalPadding = 30,
    this.borderRadius=100.0,
    this.verticalPadding=0.0,
    this.height = 35,
    required this.text,this.maxLength,this.keyboard,this.suffix,this.isobsure=false,this.validator,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
     height: height,
     decoration: BoxDecoration(
      borderRadius: BorderRadius. circular(borderRadius),
         boxShadow: [
     BoxShadow(
     color: AppColors.blackColor.withOpacity(0.4),
       offset:  Offset(
         5.0,
         5.0,
       ),
       blurRadius: 10.0,
       spreadRadius: 2.0,
     ),]
    ),//BoxS
      child: TextFormField(
        maxLength: maxLength,
        keyboardType: keyboard,
        controller: controller,
        validator: validator,
        obscureText: isobsure,
        maxLines: maxLines,
        minLines: minLines,
        style: TextStyle(color: AppColors.whiteColor),
        cursorColor: AppColors.whiteColor,
        decoration: InputDecoration(
         hintText: text,
         hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
          counterStyle: TextStyle(color: AppColors.whiteColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius. circular(100.0),
          ),
          fillColor: AppColors.textFeildColor,
          filled: true,
          suffix:suffix ,
           //suffixIcon: Center(child: CommonText(text: "psi",)),
          contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
          focusedErrorBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(borderRadius),borderSide: BorderSide(color: Colors.transparent)),
          errorBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(borderRadius),borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(borderRadius),borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(borderRadius),borderSide: BorderSide(color: Colors.transparent)),
        ),
      ),
    );
  }
}

