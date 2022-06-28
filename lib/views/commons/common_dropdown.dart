import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
class CommonDropDown extends StatefulWidget {
  List<String> items;
  String dropdownvalue;
  double ? width;
  Widget?hintText;
   void Function(String?)? onChanged;
  CommonDropDown({this.width,required this.dropdownvalue,required this.items,required this.onChanged,this.hintText});
  @override
  State<CommonDropDown> createState() => _CommonDropDownState();
}

class _CommonDropDownState extends State<CommonDropDown> {
  // String dropdownvalue = 'Item 1';
  //
  // var items = [
  //   'Item 1',
  //   'Item 2',
  //   'Item 3',
  //   'Item 4',
  //   'Item 5',
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: widget.width,
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
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
        borderRadius: BorderRadius.circular(100),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.blackColor,
            AppColors.backGroundColor
          ],
        ),
      ),
      child:  DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: widget.hintText,
          style:  TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
          ),
          isExpanded: true,
          dropdownColor: AppColors.blackColor,
          value: widget.dropdownvalue,
          icon: Icon(Icons.keyboard_arrow_down,color: AppColors().buttonColor,),
          items: widget.items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: widget.onChanged


        ),
      ),
    );
  }}