import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/config/my_size.dart';
import 'package:porelab_bubblepoint/modals/systemconfig_modal.dart';
import 'package:porelab_bubblepoint/views/commons/common_dropdown.dart';
import 'package:porelab_bubblepoint/views/commons/common_textwithdropdown.dart';
import 'package:porelab_bubblepoint/views/commons/custom_smallbutton.dart';
import 'package:porelab_bubblepoint/views/commons/custom_smallcontainer.dart';
import 'package:porelab_bubblepoint/views/commons/topheader.dart';
import 'package:porelab_bubblepoint/views/login_page/screens/home_page.dart';

import '../../../controller/hive_controller.dart';
import '../../commons/custom_button.dart';
import '../../commons/dashboard_top_header.dart';
import 'dialog_box_systemconfig.dart';

enum Categories {
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
  Box<Map>? systemConfigBox;
  TextEditingController pressureGuage1Controller = TextEditingController();
  TextEditingController pressureGuage2Controller = TextEditingController();
  TextEditingController pressureRegulatorController = TextEditingController();
  TextEditingController flowMeter1Controller = TextEditingController();
  TextEditingController flowMeter2Controller = TextEditingController();
  TextEditingController flowController = TextEditingController();
  TextEditingController firstBubbleController = TextEditingController();
  TextEditingController moderateController = TextEditingController();
  TextEditingController countiousController = TextEditingController();
  SystemConfigModal systemConfigModal =SystemConfigModal();
  final systemConfrigurationKey = GlobalKey<FormState>();
  final testConfigurationKey = GlobalKey<FormState>();
  bool scaleType1 = false;
  bool scaleType2 = false;
  bool lowPressureGuage = false;
  bool curveFit = false;
  bool valveA = false;
  bool valveB = false;
  bool valveC = false;
  bool valveD = false;
  bool valveE = false;
  bool valveF = false;
  bool valveG = false;
  bool valveH = false;

  String  valued ='Pressure Regulator Calibration';
  String selectChamber ='Manual';
  String siUnit ='psi';
  var siUnitItems = [
    'psi',
    'bar',
    'torr',
  ];
  String siUnitSecond ='psi';
  var siUnitSecondItems = [
    'psi',
    'bar',
    'torr',
  ];
  String pressure ='torr';
  var pressureItems = [
    'psi',
    'bar',
    'torr',
  ];
  String flow ='sccm';
  var flowItems = [
    'sccm',
    'sccs',
    'cfm',
  ];
  String diameter ='nm';
  var diameterItems = [
    'nm',
    'µm',
  ];

  String precision ='1';
  var precisionItems = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  String selectPort = 'selectport';
  var selectPortItems = [
    'selectport',
  ];
  Categories selectedEnum = Categories.SYSTEMCONFIGURATION;

  Widget update(Categories categories) {
    if (categories == Categories.SYSTEMCONFIGURATION) {
      return getSystemConfiguration();
    } else if (categories == Categories.TESTCONFIGURATION) {
      return getTestConfiguration();
    } else if (categories == Categories.CALIBRATION) {
      return getCalibration();
    } else if (categories == Categories.PREFERENCES) {
      return getPreferences();
    } else if (categories == Categories.COMPORT) {
      return getComport();
    } else if (categories == Categories.ADMINSCREEN1) {
      return getAdminScreen1();
    } else {
      return Container();
    }
  }

  int select = 0;

  void getSystemConfigurationdata()async{
    systemConfigBox = await HiveController().initialHivethree();
    //systemConfigBox!.clear();
    Map<dynamic,Map<dynamic, dynamic>> map =systemConfigBox!.toMap();
    map.forEach((key, value) {
        print("values:${value.runtimeType}");
       Map<String, dynamic> systemConfigModalMap = Map.castFrom(value);
       systemConfigModal=SystemConfigModal.fromMap(systemConfigModalMap);
       //print('modal:${systemConfigModal.calibration}');
       getSystemConfigdata(systemConfigModal);
    });
  }
  void getResetData(){
    siUnit ='psi';
    siUnitSecond ='psi';
    scaleType1 = false;
     scaleType2 = false;
    selectChamber ='Manual';
    lowPressureGuage = false;
     curveFit = false;
    valued ='Pressure Regulator Calibration';
    pressure ='torr';
    flow ='sccm';
    diameter ='nm';
    precision ='1';
     valveA = false;
     valveB = false;
     valveC = false;
     valveD = false;
     valveE = false;
     valveF = false;
     valveG = false;
     valveH = false;
    pressureGuage1Controller.clear();
   pressureGuage2Controller.clear();
    pressureRegulatorController.clear();
    flowMeter1Controller.clear();
    flowMeter2Controller.clear();
    flowController.clear();
    firstBubbleController.clear();
    moderateController.clear();
    countiousController.clear();
    setState((){});
    systemConfigBox!.clear();
  }

  void getSystemConfigdata(SystemConfigModal SCM){
    pressureGuage1Controller.text=SCM.pressureGuage1.toString();
    pressureGuage2Controller.text=SCM.pressureGuage2.toString();
    pressureRegulatorController.text=SCM.pressureRegulator.toString();
    flowController.text=SCM.flowController.toString();
     siUnit=SCM.setUnitOne;
     siUnitSecond=SCM.setUnitTwo;
     scaleType1=SCM.scaleTypeOne;
     scaleType2=SCM.scaleTypeTwo;
     selectChamber=SCM.selectChamber;
     lowPressureGuage=SCM.lowPressureGuage;
       curveFit=SCM.curveFit;
       firstBubbleController.text=SCM.firstBubble.toString();
       moderateController.text=SCM.moderate.toString();
       countiousController.text=SCM.continous.toString();
        valued=SCM.calibration;
       pressure=SCM.pressure;
       flow=SCM.flow;
       diameter=SCM.diameter;
       precision=SCM.precision;
       valveA=SCM.valveA;
       valveB=SCM.valveB;
       valveC=SCM.valveC;
       valveD=SCM.valveD;
       valveE=SCM.valveE;
       valveF=SCM.valveF;
       valveG=SCM.valveG;
       valveH=SCM.valveH;
       setState((){});
  }

  @override
   void initState() {
    getSystemConfigurationdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: getbody(),
    ));
  }

  Widget getbody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TopHeader(
                show: true,
                icon: Icons.arrow_back_ios_outlined,
                text: "SETTINGS",
                ontap: () {
                  Navigator.pop(context);
                },
              ),
              CustomSmallButton(icon:Icons.refresh,ontap: (){
                showDialog(context: context,
                    builder: (context) => DailogBoxSystemCongif(text: 'You want to Reset',noOnTap: (){
                      Navigator.pop(context);
                    },yesOnTap: (){
                      getResetData();
                      Navigator.pop(context);
                    },),barrierDismissible: false);
                //getResetData();
              },),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: getTab(
                    text: 'SYSTEM CONFIGURATION',
                    onTap: () {
                      selectedEnum = Categories.SYSTEMCONFIGURATION;
                      setState(() {
                        select = 0;
                      });
                    },
                    selected: 0)),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: getTab(
                    text: 'TEST CONFIGURATION',
                    onTap: () {
                      selectedEnum = Categories.TESTCONFIGURATION;
                      select = 1;
                      setState(() {});
                    },
                    selected: 1)),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: getTab(
                    text: 'CALIBRATION',
                    onTap: () {
                      selectedEnum = Categories.CALIBRATION;
                      select = 2;
                      setState(() {});
                    },
                    selected: 2)),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: getTab(
                    text: 'PREFERENCES',
                    onTap: () {
                      selectedEnum = Categories.PREFERENCES;
                      select = 3;
                      setState(() {});
                    },
                    selected: 3)),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: getTab(
                    text: 'COM PORT',
                    onTap: () {
                      selectedEnum = Categories.COMPORT;
                      select = 4;
                      setState(() {});
                    },
                    selected: 4)),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: getTab(
                    text: 'Valve Screen',
                    onTap: () {
                      selectedEnum = Categories.ADMINSCREEN1;
                      select = 5;
                      setState(() {});
                    },
                    selected: 5)),
            SizedBox(
              width: 8,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        update(selectedEnum),
      ],
    );
  }

  Widget getTab({required String text, required Function() onTap, int selected = 0}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
          borderRadius: BorderRadius.circular(10),
          color:
              select == selected ? AppColors.greyColor : AppColors.blackColor,
        ),
        child: Center(
            child: CommonText(
          text: text,
          color: select == selected ? Colors.white : AppColors.whiteColor,
        )),
      ),
    );
  }

  Widget getSystemConfiguration() {
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
                    margin: EdgeInsets.only(right: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText(
                                text: 'SET RANGE',
                                color: AppColors.whiteColor,
                                fontSize: 18)
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        getSetRangeRow(
                          title: 'Pressure Guage 1',
                          controller: pressureGuage1Controller,
                          text: "0",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        getSetRangeRow(
                          title: 'Pressure Guage 2',
                          controller: pressureGuage2Controller,
                          text: "0",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        getSetRangeRow(
                          title: 'Pressure Regulator',
                          controller: pressureRegulatorController,
                          text: "0",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
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
                        getSetRangeRow(
                          title: 'Flow Controller',
                          controller: flowController,
                          text: "0",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
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
                          Center(
                              child: Text(
                            'SET UNIT',
                            style: TextStyle(
                                color: AppColors.whiteColor, fontSize: 18),
                            textAlign: TextAlign.center,
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CommonDropDown(
                          dropdownvalue: siUnit,
                          items: siUnitItems,
                          onChanged: (String? newValue) {
                            setState(() {
                              siUnit = newValue!;
                            });
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      CommonDropDown(
                          dropdownvalue: siUnitSecond,
                          items: siUnitSecondItems,
                          onChanged: (String? newValue) {
                            setState(() {
                              siUnitSecond = newValue!;
                            });
                          }),
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
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SCALE TYPE',
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 18),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getscaleTypeRow(
                                    text1: 'Absolute',
                                    text2: 'Relative',
                                    value: scaleType1,
                                    onChanged: (bool? value) {
                                      {
                                        setState(() {
                                          scaleType1 = value!;
                                          print('print=${scaleType1}');
                                        });
                                      }
                                    }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getscaleTypeRow(
                                    text1: 'Absolute',
                                    text2: 'Relative',
                                    value: scaleType2,
                                    onChanged: (bool? value) {
                                      {
                                        setState(() {
                                          scaleType2 = value!;
                                        });
                                      }
                                    }),
                              ],
                            )
                          ],
                        )))
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButtom(
                  text: 'APPLY',
                  ontap: () {
                    if (!systemConfrigurationKey.currentState!.validate()) {
                      systemConfrigurationKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('error')),
                      );
                    } else {
                      showDialog(barrierDismissible: false,context: context,
                          builder: (context) => DailogBoxSystemCongif(text: 'You want to Save',noOnTap: (){
                            Navigator.pop(context);
                          },yesOnTap: (){
                              if(systemConfigBox!.keys.isNotEmpty){
                        systemConfigModal.pressureGuage1=double.tryParse(pressureGuage1Controller.text)?? 0.0;
                        systemConfigModal.pressureGuage2=double.tryParse(pressureGuage2Controller.text)?? 0.0;
                        systemConfigModal.pressureRegulator=double.tryParse(pressureRegulatorController.text)?? 0.0;
                        systemConfigModal.flowController=double.tryParse(flowController.text)?? 0.0;
                        systemConfigModal.setUnitOne=siUnit;
                        systemConfigModal.setUnitTwo=siUnitSecond;
                        systemConfigModal.scaleTypeOne=scaleType1;
                        systemConfigModal.scaleTypeTwo=scaleType2;
                        systemConfigBox!.putAt(0, systemConfigModal.toMap());
                        Navigator.pop(context);

                      }
                              else{
                        systemConfigModal.pressureGuage1=double.tryParse(pressureGuage1Controller.text) ?? 0.0;
                        systemConfigModal.pressureGuage2=double.tryParse(pressureGuage2Controller.text) ?? 0.0;
                        systemConfigModal.pressureRegulator=double.tryParse(pressureRegulatorController.text) ?? 0.0;
                        systemConfigModal.flowController=double.tryParse(flowController.text) ?? 0.0;
                        systemConfigModal.setUnitOne=siUnit;
                        systemConfigModal.setUnitTwo=siUnitSecond;
                        systemConfigModal.scaleTypeOne=scaleType1;
                        systemConfigModal.scaleTypeTwo=scaleType2;
                        systemConfigBox?.add(systemConfigModal.toMap());
                        Navigator.pop(context);
                      }
                          },));
                      // if(systemConfigBox!.keys.isNotEmpty){
                      //   systemConfigModal.pressureGuage1=double.tryParse(pressureGuage1Controller.text)?? 0.0;
                      //   systemConfigModal.pressureGuage2=double.tryParse(pressureGuage2Controller.text)?? 0.0;
                      //   systemConfigModal.pressureRegulator=double.tryParse(pressureRegulatorController.text)?? 0.0;
                      //   systemConfigModal.flowController=double.tryParse(flowController.text)?? 0.0;
                      //   systemConfigModal.setUnitOne=siUnit;
                      //   systemConfigModal.setUnitTwo=siUnitSecond;
                      //   systemConfigModal.scaleTypeOne=scaleType1;
                      //   systemConfigModal.scaleTypeTwo=scaleType2;
                      //   systemConfigBox!.putAt(0, systemConfigModal.toMap());
                      //
                      // }else{
                      //   systemConfigModal.pressureGuage1=double.tryParse(pressureGuage1Controller.text) ?? 0.0;
                      //   systemConfigModal.pressureGuage2=double.tryParse(pressureGuage2Controller.text) ?? 0.0;
                      //   systemConfigModal.pressureRegulator=double.tryParse(pressureRegulatorController.text) ?? 0.0;
                      //   systemConfigModal.flowController=double.tryParse(flowController.text) ?? 0.0;
                      //   systemConfigModal.setUnitOne=siUnit;
                      //   systemConfigModal.setUnitTwo=siUnitSecond;
                      //   systemConfigModal.scaleTypeOne=scaleType1;
                      //   systemConfigModal.scaleTypeTwo=scaleType2;
                      //   systemConfigBox?.add(systemConfigModal.toMap());
                      // }

                    }
                  },
                  horizonal: 70,
                  vertical: 10,
                ),
                SizedBox(
                  width: 60,
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget getSetRangeRow({int flex1 = 7, int flex2 = 3,required String text,required String title, required TextEditingController controller, required String? Function(String?)? validator, bool isFromTestConfiguration = false}) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: flex1,
                child: CommonText(
                    text: title, color: AppColors.whiteColor, fontSize: 18)),

            // SizedBox(width: 20,),
            Expanded(
                flex: flex2,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: isFromTestConfiguration ? 8.0 : 0.0),
                  child: CustomSmallContainer(
                    text: text,
                    controller: controller,
                    validator: validator,
                  ),
                )),
            isFromTestConfiguration ? Expanded(child: Container()) : Container()
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget getscaleTypeRow({double fontsize = 18, required String text1, required String text2, required bool value, required Function(bool? val)? onChanged}) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
            text: text1,
            color: AppColors.whiteColor,
            fontSize: fontsize,
            textAlign: TextAlign.center),
        SizedBox(
          width: 5,
        ),
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
                ),
              ]),
          child: CupertinoSwitch(
            activeColor: AppColors.blackColor,
            trackColor: AppColors.blackColor,
            thumbColor: AppColors.lightBlueColor,
            value: value,
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        CommonText(
          text: text2,
          color: AppColors.whiteColor,
          fontSize: fontsize,
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget getTestConfiguration() {
    return Form(
      key: testConfigurationKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            CommonText(
                              text: 'SELECT CHAMBER',
                              fontSize: 18,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CommonText(
                              text: 'LOW PRESSURE GUAGE',
                              fontSize: 18,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CommonText(
                              text: 'CURVE FIT',
                              fontSize: 18,
                            ),
                          ],
                        ),
                      ),
                      Flexible(child: Text("")),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Radio(
                                    value:'Manual' ,
                                    groupValue: selectChamber,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectChamber = value!;
                                      });
                                    }),
                                SizedBox(
                                  width: 5,
                                ),
                                CommonText(text: 'MANUAL'),
                                SizedBox(
                                  width: 20,
                                ),
                                Radio(
                                    value: 'Automated',
                                    groupValue: selectChamber,
                                    onChanged: (String ? value) {
                                      setState(() {
                                        selectChamber = value!;
                                      });
                                    }),
                                SizedBox(
                                  width: 5,
                                ),
                                CommonText(text: 'AUTOMATED')
                              ],
                            ),
                            SizedBox(height: 10,),
                            getscaleTypeRow(
                                text1: 'DISABLE',
                                text2: 'ENABLE',
                                value: lowPressureGuage,
                                onChanged: (bool? value) {
                                  {
                                    setState(() {
                                      lowPressureGuage = value!;
                                    });
                                  }
                                },
                                fontsize: 15),
                            SizedBox(height: 10,),
                            getscaleTypeRow(
                                text1: 'ON',
                                text2: 'OFF',
                                value: curveFit,
                                onChanged: (bool? value) {
                                  {
                                    setState(() {
                                      curveFit = value!;
                                    });
                                  }
                                },
                                fontsize: 15)
                          ],
                        ),
                      )
                    ],
                  ),
                )),
                Expanded(
                    child: Container(
                  // color: Colors.green,
                  // margin: EdgeInsets.only(left: 100),
                  child: Column(
                    children: [
                      CommonText(
                        text: 'Set Threshold Value',
                        fontSize: 18,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      getSetRangeRow(
                          title: 'FIRST BUBBLE',
                          text: '0',
                          controller: firstBubbleController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          flex1: 1,
                          flex2: 1,
                          isFromTestConfiguration: true),
                      // SizedBox(height: 20,),
                      getSetRangeRow(
                          title: 'MODERATE',
                          text: '0',
                          controller: moderateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          flex1: 1,
                          flex2: 1,
                          isFromTestConfiguration: true),
                      // SizedBox(height: 20,),
                      getSetRangeRow(
                          title: 'CONTINOUS',
                          text: '0',
                          controller: countiousController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          flex1: 1,
                          flex2: 1,
                          isFromTestConfiguration: true),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButtom(
                  text: 'APPLY',
                  ontap: () {
                    if (!testConfigurationKey.currentState!.validate()) {
                      testConfigurationKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('error')),
                      );
                    } else {
                      showDialog(barrierDismissible: false,context: context,
                          builder: (context) => DailogBoxSystemCongif(text: 'You want to Save',
                            noOnTap: (){
                            Navigator.pop(context);
                          },yesOnTap: (){
                              if(systemConfigBox!.keys.isNotEmpty){
                        systemConfigModal.selectChamber=selectChamber;
                        systemConfigModal.lowPressureGuage=lowPressureGuage;
                        systemConfigModal.curveFit=curveFit;
                        systemConfigModal.firstBubble=double.tryParse(firstBubbleController.text)?? 0.0;
                        systemConfigModal.continous=double.tryParse(countiousController.text)?? 0.0;
                        systemConfigModal.moderate=double.tryParse(moderateController.text)?? 0.0;
                        systemConfigBox!.putAt(0, systemConfigModal.toMap());
                        Navigator.pop(context);
                      }
                        else {
                        systemConfigModal.selectChamber = selectChamber;
                        systemConfigModal.lowPressureGuage = lowPressureGuage;
                        systemConfigModal.curveFit = curveFit;
                        systemConfigModal.firstBubble = double.tryParse(firstBubbleController.text) ?? 0.0;
                        systemConfigModal.continous = double.tryParse(countiousController.text) ?? 0.0;
                        systemConfigModal.moderate = double.tryParse(moderateController.text) ?? 0.0;
                        systemConfigBox?.add(systemConfigModal.toMap());
                        Navigator.pop(context);
                      }
                          },));
                      // if(systemConfigBox!.keys.isNotEmpty){
                      //   systemConfigModal.selectChamber=selectChamber;
                      //   systemConfigModal.lowPressureGuage=lowPressureGuage;
                      //   systemConfigModal.curveFit=curveFit;
                      //   systemConfigModal.firstBubble=double.tryParse(firstBubbleController.text)?? 0.0;
                      //   systemConfigModal.continous=double.tryParse(countiousController.text)?? 0.0;
                      //   systemConfigModal.moderate=double.tryParse(moderateController.text)?? 0.0;
                      //   systemConfigBox!.putAt(0, systemConfigModal.toMap());
                      // }
                      //   else {
                      //   systemConfigModal.selectChamber = selectChamber;
                      //   systemConfigModal.lowPressureGuage = lowPressureGuage;
                      //   systemConfigModal.curveFit = curveFit;
                      //   systemConfigModal.firstBubble = double.tryParse(firstBubbleController.text) ?? 0.0;
                      //   systemConfigModal.continous = double.tryParse(countiousController.text) ?? 0.0;
                      //   systemConfigModal.moderate = double.tryParse(moderateController.text) ?? 0.0;
                      //   systemConfigBox?.add(systemConfigModal.toMap());
                      // }
                    }
                  },
                  horizonal: 70,
                  vertical: 10,
                ),
                SizedBox(
                  width: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getCalibration() {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          CommonText(
            text: 'Select Caliration type',
            fontSize: 26,
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Radio(
                  value:'Pressure Regulator Calibration',
                  groupValue: valued,
                  onChanged: (String? value) {
                    setState(() {
                      valued = value!;
                    });
                  }),
              SizedBox(
                width: 10,
              ),
              CommonText(text: 'Pressure Regulator Calibration')
            ],
          ),
          Row(
            children: [
              Radio(
                  value:'Flow Controller Calibration',
                  groupValue: valued,
                  onChanged: (String? value) {
                    setState(() {
                      valued = value!;
                    });
                  }),
              SizedBox(
                width: 10,
              ),
              CommonText(text: 'Flow Controller Calibration')
            ],
          ),
          Row(
            children: [
              Radio(
                  value:'Troubleshoot',
                  groupValue: valued,
                  onChanged: (String? value) {
                    setState(() {
                      valued = value!;
                    });
                  }),
              SizedBox(
                width: 10,
              ),
              CommonText(text: 'Troubleshoot')
            ],
          ),
          Row(
            children: [
              Radio(
                  value:'Leak Test',
                  groupValue: valued,
                  onChanged: (String? value) {
                    setState(() {
                      valued = value!;
                    });
                  }),
              SizedBox(
                width: 10,
              ),
              CommonText(text: 'Leak Test')
            ],
          ),
          Row(
            children: [
              Radio(
                  value:'Board Calibration',
                  groupValue: valued,
                  onChanged: (String? value) {
                    setState(() {
                      valued = value!;
                    });
                  }),
              SizedBox(
                width: 10,
              ),
              CommonText(text: 'Board Calibration')
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtom(
                text: 'Start',
                ontap: () {
                  showDialog(barrierDismissible: false,context: context,
                      builder: (context) => DailogBoxSystemCongif(text: 'You want to Save',
                        noOnTap: (){
                          Navigator.pop(context);
                        },yesOnTap: (){
                        if(systemConfigBox!.keys.isNotEmpty){
                    systemConfigModal.calibration=valued;
                    systemConfigBox!.putAt(0, systemConfigModal.toMap());
                    Navigator.pop(context);
                  } else{
                    systemConfigModal.calibration=valued;
                    systemConfigBox?.add(systemConfigModal.toMap());
                    Navigator.pop(context);
                  }
                        },));

                  // if(systemConfigBox!.keys.isNotEmpty){
                  //   systemConfigModal.calibration=valued;
                  //   systemConfigBox!.putAt(0, systemConfigModal.toMap());
                  // } else{
                  //   systemConfigModal.calibration=valued;
                  //   systemConfigBox?.add(systemConfigModal.toMap());
                  // }

                },
                horizonal: 70,
                vertical: 10,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getPreferences() {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          CommonText(
            text: 'Select Unit',
            fontSize: 26,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 450,
            child: CommonTextWithDropDown(
                dropdownvalue: pressure,
                items: pressureItems,
                title: 'Pressure',
                onChanged: (String? newValue) {
                  setState(() {
                    pressure = newValue!;
                  });
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 450,
            child: CommonTextWithDropDown(
                dropdownvalue: flow,
                items: flowItems,
                title: 'Flow',
                onChanged: (String? newValue) {
                  setState(() {
                    flow = newValue!;
                  });
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 450,
            child: CommonTextWithDropDown(
                dropdownvalue: diameter,
                items: diameterItems,
                title: 'Diameter',
                onChanged: (String? newValue) {
                  setState(() {
                    diameter = newValue!;
                  });
                }),
          ),
          SizedBox(
            height: 30,
          ),
          CommonText(
            text: 'Set Data Precision',
            fontSize: 26,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              CommonText(
                text: 'Precision',
                fontSize: 25,
              ),
              SizedBox(
                width: 80,
              ),
              Container(
                width: 270,
                child: CommonDropDown(
                    dropdownvalue: precision,
                    items: precisionItems,
                    onChanged: (String? newValue) {
                      setState(() {
                        precision = newValue!;
                      });
                    }),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtom(
                text: 'Apply',
                ontap: () {
                  showDialog(barrierDismissible: false,context: context,
                      builder: (context) => DailogBoxSystemCongif(text: 'You want to Save',
                        noOnTap: (){
                          Navigator.pop(context);
                        },yesOnTap: (){
                            if(systemConfigBox!.keys.isNotEmpty){
                    systemConfigModal.pressure=pressure;
                    systemConfigModal.flow=flow;
                    systemConfigModal.diameter=diameter;
                    systemConfigModal.precision=precision;
                    systemConfigBox!.putAt(0, systemConfigModal.toMap());
                    Navigator.pop(context);
                }
                else{
                    systemConfigModal.pressure=pressure;
                    systemConfigModal.flow=flow;
                    systemConfigModal.diameter=diameter;
                    systemConfigModal.precision=precision;
                    systemConfigBox?.add(systemConfigModal.toMap());
                    Navigator.pop(context);
                }
                        },));
                //   if(systemConfigBox!.keys.isNotEmpty){
                //     systemConfigModal.pressure=pressure;
                //     systemConfigModal.flow=flow;
                //     systemConfigModal.diameter=diameter;
                //     systemConfigModal.precision=precision;
                //     systemConfigBox!.putAt(0, systemConfigModal.toMap());
                // }
                // else{
                //     systemConfigModal.pressure=pressure;
                //     systemConfigModal.flow=flow;
                //     systemConfigModal.diameter=diameter;
                //     systemConfigModal.precision=precision;
                //     systemConfigBox?.add(systemConfigModal.toMap());
                // }

                },
                horizonal: 70,
                vertical: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getComport() {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Container(
                width: 270,
                child: CommonDropDown(
                    dropdownvalue: selectPort,
                    items: selectPortItems,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectPort = newValue!;
                      });
                    }),
              ),
              SizedBox(
                width: 40,
              ),
              CommonText(
                text: 'COM : ',
                fontSize: 20,
              ),
              CommonText(
                text: selectPort,
                fontSize: 20,
              ),
            ],
          ),
          SizedBox(
            height: 250,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtom(
                text: 'Apply',
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                horizonal: 70,
                vertical: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getAdminScreen1() {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          CommonText(
            text: 'Select Letching and Nonletching Valve ',
            fontSize: 26,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      CommonText(text: 'Valve-A'),
                      SizedBox(
                        width: 50,
                      ),
                      getscaleTypeRow(
                          text1: 'off',
                          text2: 'on',
                          value: valveA,
                          onChanged: (bool? value) {
                            {
                              setState(() {
                                valveA = value!;
                              });
                            }
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      CommonText(text: 'Valve-B'),
                      SizedBox(
                        width: 50,
                      ),
                      getscaleTypeRow(
                          text1: 'off',
                          text2: 'on',
                          value: valveB,
                          onChanged: (bool? value) {
                            {
                              setState(() {
                                valveB = value!;
                              });
                            }
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      CommonText(text: 'Valve-C'),
                      SizedBox(
                        width: 50,
                      ),
                      getscaleTypeRow(
                          text1: 'off',
                          text2: 'on',
                          value: valveC,
                          onChanged: (bool? value) {
                            {
                              setState(() {
                                valveC = value!;
                              });
                            }
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      CommonText(text: 'Valve-D'),
                      SizedBox(
                        width: 50,
                      ),
                      getscaleTypeRow(
                          text1: 'off',
                          text2: 'on',
                          value: valveD,
                          onChanged: (bool? value) {
                            {
                              setState(() {
                                valveD = value!;
                              });
                            }
                          })
                    ],
                  )
                ],
              ),
              SizedBox(
                width: 100,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      CommonText(text: 'Valve-E'),
                      SizedBox(
                        width: 50,
                      ),
                      getscaleTypeRow(
                          text1: 'off',
                          text2: 'on',
                          value: valveE,
                          onChanged: (bool? value) {
                            {
                              setState(() {
                                valveE = value!;
                              });
                            }
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      CommonText(text: 'Valve-F'),
                      SizedBox(
                        width: 50,
                      ),
                      getscaleTypeRow(
                          text1: 'off',
                          text2: 'on',
                          value: valveF,
                          onChanged: (bool? value) {
                            {
                              setState(() {
                                valveF = value!;
                              });
                            }
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      CommonText(text: 'Valve-G'),
                      SizedBox(
                        width: 50,
                      ),
                      getscaleTypeRow(
                          text1: 'off',
                          text2: 'on',
                          value: valveG,
                          onChanged: (bool? value) {
                            {
                              setState(() {
                                valveG = value!;
                              });
                            }
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      CommonText(text: 'Valve-H'),
                      SizedBox(
                        width: 50,
                      ),
                      getscaleTypeRow(
                          text1: 'off',
                          text2: 'on',
                          value: valveH,
                          onChanged: (bool? value) {
                            {
                              setState(() {
                                valveH = value!;
                              });
                            }
                          })
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtom(
                text: 'Apply',
                ontap: () {
                  showDialog(barrierDismissible: false,context: context,
                      builder: (context) => DailogBoxSystemCongif(text: 'You want to Save',
                        noOnTap: (){
                          Navigator.pop(context);
                        },yesOnTap: (){
                  if(systemConfigBox!.keys.isNotEmpty){
                    systemConfigModal.valveA=valveA;
                    systemConfigModal.valveB=valveB;
                    systemConfigModal.valveC=valveC;
                    systemConfigModal.valveD=valveD;
                    systemConfigModal.valveE=valveE;
                    systemConfigModal.valveF=valveF;
                    systemConfigModal.valveG=valveG;
                    systemConfigModal.valveH=valveH;
                    systemConfigBox!.putAt(0, systemConfigModal.toMap());
                    Navigator.pop(context);
                  }
                  else{
                    systemConfigModal.valveA=valveA;
                    systemConfigModal.valveB=valveB;
                    systemConfigModal.valveC=valveC;
                    systemConfigModal.valveD=valveD;
                    systemConfigModal.valveE=valveE;
                    systemConfigModal.valveF=valveF;
                    systemConfigModal.valveG=valveG;
                    systemConfigModal.valveH=valveH;
                    systemConfigBox?.add(systemConfigModal.toMap());
                    Navigator.pop(context);
                  }

                        },));
                  // if(systemConfigBox!.keys.isNotEmpty){
                  //   systemConfigModal.valveA=valveA;
                  //   systemConfigModal.valveB=valveB;
                  //   systemConfigModal.valveC=valveC;
                  //   systemConfigModal.valveD=valveD;
                  //   systemConfigModal.valveE=valveE;
                  //   systemConfigModal.valveF=valveF;
                  //   systemConfigModal.valveG=valveG;
                  //   systemConfigModal.valveH=valveH;
                  //   systemConfigBox!.putAt(0, systemConfigModal.toMap());
                  // }
                  // else{
                  //   systemConfigModal.valveA=valveA;
                  //   systemConfigModal.valveB=valveB;
                  //   systemConfigModal.valveC=valveC;
                  //   systemConfigModal.valveD=valveD;
                  //   systemConfigModal.valveE=valveE;
                  //   systemConfigModal.valveF=valveF;
                  //   systemConfigModal.valveG=valveG;
                  //   systemConfigModal.valveH=valveH;
                  //   systemConfigBox?.add(systemConfigModal.toMap());
                  // }

                },
                horizonal: 70,
                vertical: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
