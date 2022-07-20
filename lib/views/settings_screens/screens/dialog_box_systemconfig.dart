import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';
class DailogBoxSystemCongif extends StatelessWidget {
  String text;
  Function() yesOnTap;
  Function() noOnTap;

 DailogBoxSystemCongif({required this.text,required this.yesOnTap,required this.noOnTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
    child:
    Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
    width: MediaQuery.of(context).size.width*0.3,
    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color:AppColors.blackColor,
    ),

    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(

    boxShadow: [
    BoxShadow(
color: AppColors.whiteColor,
offset: Offset(-1, -1),
blurRadius: 5.0,
spreadRadius: 2,
),
BoxShadow(
color: Colors.black,
offset: Offset(5, 5),
blurRadius: 5.0,
spreadRadius: 2,
),
],
borderRadius: BorderRadius.circular(100),
color:AppColors.blackColor
),



child: Icon(Icons.priority_high,color: Colors.white,)),
SizedBox(height: 10,),
Text('Are  you sure ',style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,),
SizedBox(height: 3,),
Text(text,style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,),
SizedBox(height: 10,),
Row(
children: [

Expanded(

child: InkWell(
onTap: noOnTap,
child: Container(
decoration: BoxDecoration(
boxShadow: [
BoxShadow(
color: AppColors.whiteColor,
offset: Offset(-1, -1),
blurRadius: 5.0,
spreadRadius: 2,
),
BoxShadow(
color: Colors.black,
offset: Offset(5, 5),
blurRadius: 5.0,
spreadRadius: 2,
),],
borderRadius: BorderRadius.circular(10),
color: AppColors.blackColor
),
padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),

child: Text('No',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)
),
),
),



SizedBox(width: 10,),
Expanded(
child: InkWell(
onTap: yesOnTap,
child: Container(
decoration: BoxDecoration(
boxShadow: [
BoxShadow(
color: AppColors.whiteColor,
offset: Offset(-1, -1),
blurRadius: 5.0,
spreadRadius: 2,
),
BoxShadow(
color: Colors.black,
offset: Offset(5, 5),
blurRadius: 5.0,
spreadRadius: 2,
),],
borderRadius: BorderRadius.circular(10),
color: AppColors.blackColor
),
padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),

child: Text('Yes',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
),
),
)
],
)
],
),

),
),

);;
  }
}
