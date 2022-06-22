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
  CustomTextFeild({
    this.width=double.maxFinite,
    required this.text,this.maxLength,this.keyboard,this.suffix,this.isobsure=false,this.validator,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
     height: 35,
     decoration: BoxDecoration(
      borderRadius: BorderRadius. circular(100.0),
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
        style: TextStyle(color: AppColors.whiteColor),
        cursorColor: AppColors.whiteColor,
        decoration: InputDecoration(
         hintText: text,
         hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
          counterStyle: TextStyle(color: AppColors.whiteColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius. circular(100.0),
          ),
          fillColor: AppColors.textFeildColor,
          filled: true,
          suffix:suffix ,
           //suffixIcon: Center(child: CommonText(text: "psi",)),
          contentPadding: EdgeInsets.symmetric(horizontal: 30),
          focusedErrorBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
          errorBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
        ),
      ),
    );
  }
}

