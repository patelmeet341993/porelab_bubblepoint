import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/app_colors.dart';
class CommonTextfeildwithGradient extends StatelessWidget {
  List<TextInputFormatter>? inputformatters;
  String ? text;
  double width;
  int ? maxLength;
  TextAlign textAlign;
  Widget ? suffixicon;
  TextInputType ? keyboard;
  TextEditingController controller;
  String? Function(String?)? validator;
  CommonTextfeildwithGradient({this.inputformatters,this.suffixicon,this.width=double.maxFinite,this.textAlign=TextAlign.start,this.text,this.keyboard,this.validator,required this.controller});


  @override
  Widget build(BuildContext context) {
    return  Container(
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
        textAlign: textAlign,
        inputFormatters: inputformatters,
        keyboardType: keyboard,
        controller: controller,
        validator: validator,
        style: TextStyle(color: AppColors.whiteColor),
        cursorColor: AppColors.whiteColor,
        decoration: InputDecoration(

          suffixIcon: suffixicon,
          hintText: text,
          hintStyle: TextStyle(fontSize: 16,color: AppColors.whiteColor),
          counterStyle: TextStyle(color: AppColors.whiteColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius. circular(100.0),
          ),
          fillColor:Colors.transparent,
          filled: true,
          contentPadding: EdgeInsets.only(left: 11,right: 3,top: 14,bottom: 14),
errorStyle: TextStyle(fontSize: 9,height: 0.3),
          focusedErrorBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
          errorBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
        ),

      ),
    );
  }
}
