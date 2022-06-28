import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/views/commons/common_dropdown.dart';
import 'package:porelab_bubblepoint/views/commons/common_textwithdropdown.dart';
import 'package:porelab_bubblepoint/views/commons/custom_smallbutton.dart';
import 'package:porelab_bubblepoint/views/commons/custom_smallcontainer.dart';
import 'package:porelab_bubblepoint/views/commons/topheader.dart';
import 'package:porelab_bubblepoint/views/login_page/screens/home_page.dart';

import '../../commons/custom_button.dart';
import '../../commons/dashboard_top_header.dart';
enum Categories{
  SYSTEMCONFIGURATION,
  TESTCONFIGURATION,
   CALIBRATION,
   PREFERENCES,
   COMPORT,
  ADMINSCREEN1
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
 bool scaleType1=false;
 bool scaleType2=false;
 bool disableEnable1=false;
 bool disableEnable2=false;
 bool valveA=false;
 bool valveB=false;
 bool valveC=false;
 bool valveD=false;
 bool valveE=false;
 bool valveF=false;
 bool valveG=false;
 bool valveH=false;

 int valued=1;
int selectChamber=1;
  String siUnit = 'psi';
  var siUnitItems = [
    'psi',
    'bar',
    'torr',

  ];
  String siUnitSecond = 'psi';
  var siUnitSecondItems = [
    'psi',
    'bar',
    'torr',

  ];
  String pressure = 'torr';
  var pressureItems = [
    'psi',
    'bar',
    'torr',
  ];
  String flow = 'sccm';
  var flowItems = [
    'sccm',
    'sccs',
    'cfm',
  ];
  String diameter = 'nm';
  var diameterItems = [
    'nm',
    'µm',
  ];

  String precision = '1';
  var  precisionItems = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  String selectPort = 'selectport';
  var  selectPortItems = [
    'selectport',

  ];
  Categories selectedEnum = Categories.SYSTEMCONFIGURATION;
  Widget update(Categories  categories){
    if(categories==Categories.SYSTEMCONFIGURATION){
      return getSystemConfiguration();
    }
    else if(categories==Categories.TESTCONFIGURATION){
      return getTestConfiguration();
    }
    else if(categories==Categories.CALIBRATION){
      return getCalibration();
    }
    else if(categories==Categories.PREFERENCES){
      return getPreferences();
    }
    else if(categories==Categories.COMPORT){
      return getComport();
    }
    else if(categories==Categories.ADMINSCREEN1){
      return getAdminScreen1();
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
              selectedEnum=Categories.CALIBRATION;
              select=2;
              setState((){

              });
              },selected: 2)),
            SizedBox(width: 8,),
            Expanded(child: getTab(text: 'PREFERENCES',onTap: (){
              selectedEnum=Categories.PREFERENCES;
              select=3;
              setState((){

              });
              },selected: 3)),
            SizedBox(width: 8,),
                      Expanded(child: getTab(text: 'COM PORT',onTap: (){
                        selectedEnum=Categories.COMPORT;
              select=4;
              setState((){

              });
              },selected: 4)),
            SizedBox(width: 8,),
            Expanded(child: getTab(text: 'ADMIN SCREEN 1',onTap: (){
              selectedEnum=Categories.ADMINSCREEN1;
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
                        // getSetRangeRow(title: 'Flow Meter 1',controller: flowMeter1Controller,text: "0",validator:
                        //     (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter some text';
                        //   }
                        //   return null;
                        // },),
                        // getSetRangeRow(title: 'Flow Meter 2',controller: flowMeter2Controller,text: "0",validator:
                        //     (value) {
                        //       if (value == null || value.isEmpty) {
                        //       return 'Please enter some text';
                        //       }
                        //       return null;
                        //       },),
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
                        CommonDropDown(dropdownvalue: siUnit, items: siUnitItems, onChanged:(String? newValue) {
                          setState(() {
                            siUnit  = newValue!;
                          });} ),
                      SizedBox(height: 10,),
                         CommonDropDown(dropdownvalue: siUnitSecond, items: siUnitSecondItems, onChanged:(String? newValue) {
                           setState(() {
                             siUnit  = newValue!;
                           });} ),
                      // SizedBox(height: 10,),
                      // Container(
                      //  padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                      // ),
                      // SizedBox(height: 10,),
                         // CustomSmallContainer(text: 'sccm',),
                         // SizedBox(height: 10,),
                         // CustomSmallContainer(text: 'sccm',),
                         // SizedBox(height: 10,),
                         // Container(
                         //   padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                         // ),
                         // SizedBox(height: 10,),


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
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
        SizedBox(width: 5,),
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
        SizedBox(width: 5,),
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
                    CommonText(text: 'CURVE FIT',fontSize: 18,),
                ],
                )),
                Expanded(
                  flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    SizedBox(height: 40,),
                      Row(
                        children: [
                         Radio(
                             value: 1,
                             groupValue: selectChamber,
                             onChanged:  (int?value){
                               setState((){
                                 selectChamber=value!;
                               });
                             }),
                          SizedBox(width: 5,),
                          CommonText(text: 'Manual'),
                          SizedBox(width: 100,),
                          Radio(
                              value: 2,
                              groupValue: selectChamber,
                              onChanged:  (int?value){
                                setState((){
                                  selectChamber=value!;
                                });
                              }),
                          SizedBox(width: 5,),
                          CommonText(text: 'Automated')

                        ],
                      ),
                      getscaleTypeRow(text1: 'DISABLE',text2: 'ENABLE',value:disableEnable1 ,

                          onChanged:(bool ? value){
                            {
                              setState(() {
                                disableEnable1 = value!;

                              });
                            }}),
                      getscaleTypeRow(text1: 'ON',text2: 'OFF',value: disableEnable2,

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

                       CommonText(text: 'Set Threshold Value',fontSize: 18,),
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
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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

  Widget getCalibration(){
    return Container(
      margin: EdgeInsets.only(right: 20,left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
                CommonText(text: 'Select Caliration type',fontSize: 26,),
          SizedBox(height: 40,),
            Row(
              children: [
                Radio(
                    value: 1,
                    groupValue: valued,
                    onChanged: (int?value){
                      setState((){
                        valued=value!;
                      });
                    }),
                SizedBox(width: 10,),
                CommonText(text: 'Pressure Regulator Calibration')
              ],
            ),
          Row(
            children: [
              Radio(
                  value: 2,
                  groupValue: valued,
                  onChanged: (int?value){
                    setState((){
                      valued=value!;
                    });
                  }),
              SizedBox(width: 10,),
              CommonText(text: 'Flow Controller Calibration')
            ],
          ),
          Row(
            children: [
              Radio(
                  value: 3,
                  groupValue: valued,
                  onChanged: (int?value){
                    setState((){
                      valued=value!;
                    });
                  }),
              SizedBox(width: 10,),
              CommonText(text: 'Troubleshoot')
            ],
          ),
          Row(
            children: [
              Radio(
                  value: 4,
                  groupValue: valued,
                  onChanged: (int?value){
                    setState((){
                      valued=value!;
                    });
                  }),
              SizedBox(width: 10,),
              CommonText(text: 'Leak Test')
            ],
          ),
          Row(
            children: [
              Radio(
                  value: 5,
                  groupValue: valued,
                  onChanged: (int? value){
                    setState((){
                      valued=value!;
                    });
                  }),
              SizedBox(width: 10,),
              CommonText(text: 'Board Calibration')
            ],
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtom(text: 'Start',ontap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>HomePage()),
                );
              },),
            ],
          )

        ],
      ),
    ) ;
  }

  Widget getPreferences(){
    return Container(
      margin: EdgeInsets.only(right: 20,left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          CommonText(text: 'Select Unit',fontSize: 26,),
          SizedBox(height: 20,),
          Container(
            width: 450,
            child: CommonTextWithDropDown(dropdownvalue: pressure, items: pressureItems, title: 'Pressure', onChanged: (String? newValue) {
              setState(() {
                pressure  = newValue!;
              });} ),
          ),
          SizedBox(height: 10,),
          Container(
            width: 450,
            child: CommonTextWithDropDown(dropdownvalue: flow, items: flowItems, title: 'Pressure', onChanged: (String? newValue) {
              setState(() {
                flow  = newValue!;
              });} ),
          ),
          SizedBox(height: 10,),
          Container(
            width: 450,
            child: CommonTextWithDropDown(dropdownvalue: diameter, items: diameterItems, title: 'Pressure', onChanged: (String? newValue) {
              setState(() {
                diameter  = newValue!;
              });} ),
          ),
          SizedBox(height: 30,),
          CommonText(text: 'Set Data Precision',fontSize: 26,),
          SizedBox(height: 20,),
          Row(
            children: [
              SizedBox(width: 180,),
              Container(
                width: 270,
                child: CommonDropDown(dropdownvalue: precision, items: precisionItems,onChanged: (String? newValue) {
                  setState(() {
                    precision  = newValue!;
                  });} ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtom(text: 'Apply',ontap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>HomePage()),
                );
              },),
            ],
          ),
        ],
      ),
    );
  }

  Widget getComport(){
    return Container(
      margin: EdgeInsets.only(right: 20,left: 20),
      child: Column(
        children: [
          SizedBox(height: 30,),
          Row(
            children: [
              Container(
                width: 270,
                child: CommonDropDown(dropdownvalue: selectPort, items: selectPortItems,onChanged: (String? newValue) {
                  setState(() {
                    selectPort  = newValue!;
                  });} ),
              ),
              SizedBox(width: 40,),
              CommonText(text: 'COM : ',fontSize: 20,),
              CommonText(text: selectPort,fontSize: 20,),

            ],
          ),
          SizedBox(height: 250,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtom(text: 'Apply',ontap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>HomePage()),
                );
              },),
            ],
          ),
        ],
      ),
    );
  }

  Widget getAdminScreen1(){
    return Container(
      margin: EdgeInsets.only(right: 20,left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        CommonText(text: 'Select Letching and Nonletching Valve ',fontSize: 26,),
        SizedBox(height: 20,),
          Row(
            children: [
              Column(

                children: [
                 Row(
                   children: [
                     CommonText(text: 'Valve-A'),
                     SizedBox(width: 50,),
                     getscaleTypeRow(text1: 'off', text2: 'on', value: valveA, onChanged: (bool ? value){
                       {
                         setState(() {
                           valveA= value!;
                         });
                       }})
                   ],
                 ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      CommonText(text: 'Valve-B'),
                      SizedBox(width: 50,),
                      getscaleTypeRow(text1: 'off', text2: 'on', value: valveB, onChanged: (bool ? value){
                        {
                          setState(() {
                            valveB= value!;
                          });
                        }})
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      CommonText(text: 'Valve-C'),
                      SizedBox(width: 50,),
                      getscaleTypeRow(text1: 'off', text2: 'on', value: valveC, onChanged: (bool ? value){
                        {
                          setState(() {
                            valveC= value!;
                          });
                        }})
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      CommonText(text: 'Valve-D'),
                      SizedBox(width: 50,),
                      getscaleTypeRow(text1: 'off', text2: 'on', value: valveD, onChanged: (bool ? value){
                        {
                          setState(() {
                            valveD= value!;
                          });
                        }})
                    ],
                  )
                ],
              ),
              SizedBox(width: 100,),
              Column(
                children: [
                  Row(
                    children: [
                      CommonText(text: 'Valve-E'),
                      SizedBox(width: 50,),
                      getscaleTypeRow(text1: 'off', text2: 'on', value: valveE, onChanged: (bool ? value){
                        {
                          setState(() {
                            valveE= value!;
                          });
                        }})
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      CommonText(text: 'Valve-F'),
                      SizedBox(width: 50,),
                      getscaleTypeRow(text1: 'off', text2: 'on', value: valveF, onChanged: (bool ? value){
                        {
                          setState(() {
                            valveF= value!;
                          });
                        }})
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      CommonText(text: 'Valve-G'),
                      SizedBox(width: 50,),
                      getscaleTypeRow(text1: 'off', text2: 'on', value: valveG, onChanged: (bool ? value){
                        {
                          setState(() {
                            valveG= value!;
                          });
                        }})
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      CommonText(text: 'Valve-H'),
                      SizedBox(width: 50,),
                      getscaleTypeRow(text1: 'off', text2: 'on', value: valveH, onChanged: (bool ? value){
                        {
                          setState(() {
                            valveH= value!;
                          });
                        }})
                    ],
                  )
                ],
              )
            ],
          ),
        SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtom(text: 'Apply',ontap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>HomePage()),
              );
            },),
          ],
        ),
      ],
    ),
    );
  }

}
