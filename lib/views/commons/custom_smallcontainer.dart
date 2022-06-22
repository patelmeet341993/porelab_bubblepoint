import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/common_boldtext.dart';

import '../../config/app_colors.dart';
class CustomSmallContainer extends StatefulWidget {
  String text;

  TextAlign textAlign;
  TextInputType ? keyboard;
  TextEditingController ?controller;
  String? Function(String?)? validator;
  CustomSmallContainer({required this.text,this.textAlign=TextAlign.center,this.keyboard,this.validator,this.controller});

  @override
  State<CustomSmallContainer> createState() => _CustomSmallContainerState();
}

class _CustomSmallContainerState extends State<CustomSmallContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      constraints: BoxConstraints(
        minWidth: 120,
        maxWidth: 120
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),

      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: AppColors.whiteColor,
            offset: Offset(-1, -1),
            blurRadius: 2.0,
            spreadRadius:1,
          ),
          BoxShadow(
            color: Colors.black,
            offset: Offset(1, 1),
            blurRadius: 2.0,
            spreadRadius:1,
          ),
        ],
      ),
      child:/*CommonBoldText(text: widget.text,textAlign:TextAlign.center,color: AppColors.whiteColor,fontSize: 14,fontWeight:  FontWeight.bold,) */
      TextFormField(
        textAlign: widget.textAlign,
        keyboardType: widget.keyboard,
        controller: widget.controller,
        validator: widget.validator,
        style: TextStyle(color: AppColors.whiteColor),
        cursorColor: AppColors.whiteColor,
        decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: TextStyle(fontSize: 16,color: AppColors.whiteColor),
          counterStyle: TextStyle(color: AppColors.whiteColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius. circular(100.0),
          ),
          fillColor:Colors.transparent,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 30),
          focusedErrorBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
          errorBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
        ),

      )
    );
  }
}

