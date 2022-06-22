import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/views/commons/custom_smallbutton.dart';
import 'package:porelab_bubblepoint/views/commons/custom_smallcontainer.dart';
import 'package:porelab_bubblepoint/views/commons/topheader.dart';
import 'package:porelab_bubblepoint/views/login_page/screens/home_page.dart';

import '../../commons/custom_button.dart';
import '../../commons/dashboard_top_header.dart';
enum Categories{
  SYSTEMCONFIGURATION,
  TESTCONFIGURATION,
  // CALIBRATION,
  // PREFERENCES,
  // GENERALSETTING,
  // ADMINSCREEN1
}
class SystemConfiguration extends StatefulWidget {
  const SystemConfiguration({Key? key}) : super(key: key);

  @override
  State<SystemConfiguration> createState() => _SystemConfigurationState();
}

class _SystemConfigurationState extends State<SystemConfiguration> {
  TextEditingController pressureGuage1Controller=TextEditingController();
  TextEditingController pressureGuage2Controller=TextEditingController();
  TextEditingController pressureRegulatorController=TextEditingController();
  TextEditingController flowMeter1Controller=TextEditingController();
  TextEditingController flowMeter2Controller=TextEditingController();
  TextEditingController flowController=TextEditingController();
  TextEditingController firstBubbleController=TextEditingController();
  TextEditingController moderateController=TextEditingController();
  TextEditingController countiousController=TextEditingController();
  final systemConfrigurationKey = GlobalKey<FormState>();
  final testConfigurationKey = GlobalKey<FormState>();
 var scaleType1=false;
 var scaleType2=false;
 var disableEnable1=false;
 var disableEnable2=false;
  Categories selectedEnum = Categories.SYSTEMCONFIGURATION;
  Widget update(Categories  categories){
    if(categories==Categories.SYSTEMCONFIGURATION){
      return getSystemConfiguration();
    }
    else if(categories==Categories.TESTCONFIGURATION){
      return getTestConfiguration();
    }
    else{
      return Container();
    }
  }
   int select=0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: getbody(),
    ));
  }
  Widget getbody(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopHeader(show:true,icon:Icons.arrow_back_ios_outlined ,text: "SETTINGS",ontap: (){
          Navigator.pop(context);
        },),
        SizedBox(height: 25,),
        Row(
          children: [
            SizedBox(width: 8,),
            Expanded(child: getTab(text: 'SYSTEM CONFIGURATION',onTap: (){
              selectedEnum=Categories.SYSTEMCONFIGURATION;
              setState((){
                select=0;
              });

            },selected: 0
            )),
            SizedBox(width: 8,),
           Expanded(child: getTab(text: 'TEST CONFIGURATION',
               onTap: (){
             selectedEnum=Categories.TESTCONFIGURATION;
              select=1;
              setState((){

              });
              },selected: 1)),
            SizedBox(width: 8,),
            Expanded(child: getTab(text: 'CALIBRATION',onTap: (){
              select=2;
              setState((){

              });
              },selected: 2)),
            SizedBox(width: 8,),
            Expanded(child: getTab(text: 'PREFERENCES',onTap: (){
              select=3;
              setState((){

              });
              },selected: 3)),
            SizedBox(width: 8,),
                      Expanded(child: getTab(text: 'GENERAL SETTING',onTap: (){
              select=4;
              setState((){

              });
              },selected: 4)),
            SizedBox(width: 8,),
            Expanded(child: getTab(text: 'ADMIN SCREEN 1',onTap: (){
                select=5;
                setState((){

                });
                },selected: 5)),
            SizedBox(width: 8,),
          ],
        ),
        SizedBox(height: 10,),
        update(selectedEnum),
      ],
    );
  }

  Widget getTab({required String text, required Function()  onTap,int selected=0}){
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.whiteColor,
              offset: Offset(-1, -1),
              blurRadius: 5.0,
              spreadRadius:2,
            ),
            BoxShadow(
              color: Colors.black,
              offset: Offset(5, 5),
              blurRadius: 5.0,
              spreadRadius:2,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color:  select==selected ? AppColors.greyColor :AppColors.blackColor,
        ),
        child: Center(child:CommonText(text: text,color:select==selected ? AppColors.blackColor :AppColors.whiteColor,) ),

      ),
    );
  }

  Widget getSystemConfiguration(){
    return Form(
      key: systemConfrigurationKey,
      child: Container(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(

                    margin: EdgeInsets.only(right: 20,left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText(text: 'SET RANGE',color: AppColors.whiteColor,fontSize: 18)

                          ],
                        ),
                        SizedBox(height: 30,),
                        getSetRangeRow(title: 'Pressure Guage 1',controller:pressureGuage1Controller,text: "0",validator:
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }, ),
                        getSetRangeRow(title: 'Pressure Guage 2',controller: pressureGuage2Controller,text: "0",validator:
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },),
                        getSetRangeRow(title: 'Pressure Regulator',controller: pressureRegulatorController,text: "0",validator:
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },),
                        getSetRangeRow(title: 'Flow Meter 1',controller: flowMeter1Controller,text: "0",validator:
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },),
                        getSetRangeRow(title: 'Flow Meter 2',controller: flowMeter2Controller,text: "0",validator:
                            (value) {
                              if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                              }
                              return null;
                              },),
                        getSetRangeRow(title: 'Flow Controller',controller: flowController,text: "0",validator:
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },),
                      ],
                    ),
                  ),
                ),
                Flexible(
                    child: Container(
                       child: Column(
                        //crossAxisAlignment:CrossAxisAlignment.start,
                       children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Center(child: Text('SET UNIT',style: TextStyle(color: AppColors.whiteColor,fontSize: 18),textAlign: TextAlign.center,))
                        ],
                      ),
                      SizedBox(height: 30,),
                         CustomSmallContainer(text: 'psi',),
                      SizedBox(height: 10,),
                         CustomSmallContainer(text: 'psi',),
                      SizedBox(height: 10,),
                      Container(
                       padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                      ),
                      SizedBox(height: 10,),
                         CustomSmallContainer(text: 'sccm',),
                         SizedBox(height: 10,),
                         CustomSmallContainer(text: 'sccm',),
                         SizedBox(height: 10,),
                         Container(
                           padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                         ),
                         SizedBox(height: 10,),


                  ],
                ),
                    )),
                Expanded(
                    child: Container(

                    margin: EdgeInsets.only(right: 20,left: 20),
                    child: Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         // crossAxisAlignment:CrossAxisAlignment.start,
                         children: [
                           Text('SCALE TYPE',style: TextStyle(color: AppColors.whiteColor,fontSize: 18),textAlign: TextAlign.center,)
                         ],
                       ),
                       SizedBox(height: 30,),
                       getscaleTypeRow(text1: 'Absolute',text2: 'Relative',value:scaleType1 ,

                           onChanged:(bool ? value){
                             {
                               setState(() {
                                 scaleType1 = value!;

                             });
                             }}),
                       getscaleTypeRow(text1: 'Absolute',text2: 'Relative',value: scaleType2,

                            onChanged:(bool ? value){
                            {
                            setState(() {
                            scaleType2 = value!;
                            });
                            }})
                     ],
                    )
                )
                )
              ],
            ),
            SizedBox(height: 150,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButtom(text: 'APPLY', ontap: (){
      if (!systemConfrigurationKey.currentState!.validate()) {
      systemConfrigurationKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('error')),
      );
      }
      else{
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>HomePage()),
      );
      }
      },),
                SizedBox(width: 60,),
              ],
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );


  }

  Widget getSetRangeRow({required String text,required String title,required TextEditingController controller, required String? Function(String?)? validator}){
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: 7,
                child:CommonText(text: title,color: AppColors.whiteColor,fontSize: 18) ),

            SizedBox(width: 20,),
            Expanded(
              flex: 3,
              child: CustomSmallContainer(text: text,controller: controller,validator:validator ,)
            )
          ],
        ),
        SizedBox(height: 10,)
      ],
    );
  }

  Widget getscaleTypeRow({required String text1,required String text2, required bool value,required Function(bool? val)? onChanged  } ){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         CommonText(text: text1, color:AppColors.whiteColor,fontSize: 18,textAlign: TextAlign.center),

        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  offset: Offset(-2.0, -2.0),
                  blurRadius: 4.0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(3.0, 3.0),
                  blurRadius: 4.0,
                ),]
          ),
          child: CupertinoSwitch(
            activeColor: AppColors.blackColor,
            trackColor: AppColors.blackColor,
            thumbColor: AppColors.lightBlueColor,
            value: value,
            onChanged:onChanged,
          ),
        ),
        CommonText(text: text2,color: AppColors.whiteColor,fontSize: 18,textAlign: TextAlign.center,)

      ],
    );
 }

  Widget getTestConfiguration(){
    return Form(
      key: testConfigurationKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
        child:Column(
          children: [
            Row(
              children: [
                Expanded(flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:MainAxisAlignment.start ,

                  children: [
                   SizedBox(height: 30,),
                   CommonText(text: 'SELECT CHAMBER',fontSize: 18,),
                    SizedBox(height: 20,),
                    CommonText(text: 'LOW PRESSURE GUAGE',fontSize: 18,),
                    SizedBox(height: 20,),
                    CommonText(text: 'LOW FLOW METER',fontSize: 18,),
                    SizedBox(height: 20,),
                    CommonText(text: 'CURVE FIT',fontSize: 18,)
                ],
                )),
                Expanded(
                  flex: 2,
                    child: Column(

                    children: [
                    SizedBox(height: 35,),
                      getscaleTypeRow(text1: 'DISABLE',text2: 'ENABLE',value:disableEnable1 ,

                          onChanged:(bool ? value){
                            {
                              setState(() {
                                disableEnable1 = value!;

                              });
                            }}),
                      getscaleTypeRow(text1: 'DISABLE',text2: 'ENABLE',value: disableEnable2,

                          onChanged:(bool ? value){
                            {
                              setState(() {
                                disableEnable2= value!;
                              });
                            }})

                  ],


                )),
                Expanded(
                  flex: 4,
                    child: Container(
                      margin: EdgeInsets.only(left: 100),
                      child: Column(
                        children: [

                       CommonText(text: 'Set Threshold Value'),
                         SizedBox(height: 50,),
                       getSetRangeRow(title: 'FIRST BUBBLE',text: '0',controller: firstBubbleController,validator:
                           (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please enter some text';
                         }
                         return null;
                       },),
                         SizedBox(height: 20,),
                         getSetRangeRow(title: 'MODERATE',text: '0',controller: moderateController,validator:
                             (value) {
                           if (value == null || value.isEmpty) {
                             return 'Please enter some text';
                           }
                           return null;
                         },),
                         SizedBox(height: 20,),
                         getSetRangeRow(title: 'CONTINOUS',text: '0',controller: countiousController,validator:
                             (value) {
                           if (value == null || value.isEmpty) {
                             return 'Please enter some text';
                           }
                           return null;
                         },),
                         SizedBox(height: 20,),

                   ],

                ),
                    ))
              ],
            ),
            SizedBox(height: 150,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButtom(text: 'APPLY',ontap: (){
                  if (!testConfigurationKey.currentState!.validate()) {
                    testConfigurationKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('error')),
                    );
                  }
                  else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>HomePage()),
                    );
                  }
                },),
                SizedBox(width: 50,),
              ],
            ),

          ],
        ),
      ),
    ) ;
  }
}
