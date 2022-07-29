import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/views/commons/common_dropdown.dart';
import 'package:porelab_bubblepoint/views/commons/common_radio.dart';
import 'package:porelab_bubblepoint/views/commons/common_textfeild.dart';
import 'package:porelab_bubblepoint/views/commons/common_textfeildwith_gradient.dart';
import 'package:porelab_bubblepoint/views/commons/common_textwithdropdown.dart';
import 'package:porelab_bubblepoint/views/commons/custom_button.dart';
import 'package:porelab_bubblepoint/views/commons/custom_smallbutton.dart';
import 'package:porelab_bubblepoint/views/login_page/screens/home_page.dart';
import 'package:porelab_bubblepoint/views/login_page/screens/login_screen.dart';

import '../../../controller/hive_controller.dart';
import '../../../modals/test_setup_modal.dart';
import '../../commons/common_increasedecrease.dart';
import '../../commons/common_textandtextfeild.dart';
import '../../commons/common_textandtextfeild.dart';
import '../../commons/dashboard_top_header.dart';
import '../../commons/topheader.dart';
import '../../settings_screens/screens/dialog_box_systemconfig.dart';
class QuickTest extends StatefulWidget {
  const QuickTest({Key? key}) : super(key: key);

  @override
  State<QuickTest> createState() => _QuickTestState();
}

class _QuickTestState extends State<QuickTest> {
  Box<Map>? firstBox,dropDownBox;
  String wettingFluids = "Water";


  Map<String,String> wettingFluidsItems ={
    "AddFluid":"0.0",
    "Water":"72.0",
    "MineralOil":"34.7",
    "PetroleumDistillate":"30.0",
    "DenaturedAlcohol":"22.3",
    "Porewick":"16.0",
    "Galwick":"15.9",
  };

  Map<String,String> wettingFluidsItemsTwo ={
    "AddFluid":"0.0",
    "Water":"72.0",
    "MineralOil":"34.7",
    "PetroleumDistillate":"30.0",
    "DenaturedAlcohol":"22.3",
    "Porewick":"16.0",
    "Galwick":"15.9",
  };
  void getDropDownData() async {
    dropDownBox = await HiveController().initialHivetwo();
    // dropDownBox!.clear();
    dropDownBox!.values.forEach((element) {
      wettingFluidsItemsTwo.addAll(Map.castFrom<dynamic,dynamic,String,String>(element));
    });
    print("dropdownmenu $dropDownBox");
  }
  TestSetupModal testSetupModal =TestSetupModal();
  void getTestSetList()async{
    sampleId = null;
    firstBox = await HiveController().initialHive();
    // firstBox!.clear();
    Map<dynamic,Map<dynamic, dynamic>> map =firstBox!.toMap();
    // print("Value:${value}, Type:${value.runtimeType}");

    map.forEach((key, value) {
      // print("Key:${key}, Type:${key.runtimeType}");
      // print("Value:${value}, Type:${value.runtimeType}");

      Map<String, dynamic> testSetupModalMap = {};
      if(value is Map) {
        try {
          testSetupModalMap = Map.castFrom<dynamic, dynamic, String, dynamic>(value);
        }
        catch(e) {}
      }

      if(testSetupModalMap.isNotEmpty && key is String) {
        sampleIdItems[key] = TestSetupModal.fromMap(testSetupModalMap);
      }
    });
    sampleId = sampleIdItems.keys.first;
    // print("length:${sampleIdItems.keys.first.runtimeType}");
    setState((){});
  }


 void  getsetData(TestSetupModal tSM){
    testSetupModal = tSM;
    sampleIdController.text=tSM.sampleProfile;
     lotNoController.text=tSM.lotNumber;
     TurtuosityController.text=tSM.turtosity.toString();
    wettingFluids=tSM.wettingFluid.keys.first;
     // wettingFluidController.text =tSM.wettingFluid.keys.first + ' : ' +tSM.wettingFluid.values.first;
     // print('wetting ${wettingFluidController.text}');
    bptThershold=tSM.bubblePointType;
    BptAccuracyController.text=tSM.bubblePoint.toString();
    testPressureFirstValueController.text=tSM.testPressureone.toString();
    testPressureSecondValueController.text=tSM.testPressuretwo.toString();

    setState((){});
  }


  String? sampleId;

  int curentStep =0;

  Map<String,TestSetupModal> sampleIdItems={};

  String bptThershold = 'First Bubble';
  var bptThersholditems = [
    'First Bubble',
    'Moderate',
    'Countinous',
  ];
  String testTrail = '1';
  var testTrailItems = [
    '1',
    '2',
     '3',
    '4',
    '5',
  ];
  String wettingFluid = '1';
  var wettingFluidItems = [
    '1',
    '3',
    '4',
    '5',
    '6',
  ];
   int testConfriguration=1;
   int testMethod=1;
   int samplePlate=1;
  TextEditingController sampleIdController=TextEditingController();
  TextEditingController bubblePointController=TextEditingController();
  TextEditingController TurtuosityController=TextEditingController();
  TextEditingController lotNoController=TextEditingController();
  TextEditingController bptThresholdController=TextEditingController();
  TextEditingController BptAccuracyController=TextEditingController();
  TextEditingController testAccuracyController=TextEditingController();
  TextEditingController dataStabilityController=TextEditingController();
  TextEditingController wettingFluidController=TextEditingController();
  TextEditingController testPressureFirstValueController=TextEditingController();
  TextEditingController testPressureSecondValueController=TextEditingController();
  TextEditingController addFluidNameController=TextEditingController();
  TextEditingController addFluidValueController=TextEditingController();
  final Key = GlobalKey<FormState>();

  @override
  void initState(){
    sampleIdItems["select Project"]=TestSetupModal();
    getTestSetList();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: getbody(),
    ));
  }
  Widget getbody(){
    return Form(
      key: Key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        getHeader(),
        SizedBox(height: 25,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: getLeftConatiner()),
              SizedBox(width: 20,),
              Expanded(child: getRightContainer())
            ],
          ),
        ),
          getBottmContainer()
        ],
      ),
    );
  }
  Widget getHeader(){
    return Row(
      children: [
        Column(
          children: [
            TopHeader(show:true,icon:Icons.arrow_back_ios_outlined ,text: "QUICK TEST",ontap: (){
              showDialog(barrierDismissible: false,context: context,
                  builder: (context) => DailogBoxSystemCongif(text: 'You want to Close Test',
                    noOnTap: (){
                      Navigator.pop(context);
                    },yesOnTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );

                    },));
            },)
          ],
        ),
        SizedBox(width: 30,),
        Expanded(
          child: Column(
            children: [
              Container(
                height: 35,
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
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    style:  TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                    ),
                    isExpanded: true,
                    dropdownColor: AppColors.blackColor,
                    value: sampleId,
                    icon: Icon(Icons.keyboard_arrow_down,color: AppColors().buttonColor,),
                    // items: sampleIdItems
                    items: sampleIdItems.entries.map((MapEntry e) {
                      return DropdownMenuItem<String>(child: Text("${e.key}"), value: e.key,);
                    }).toList(),
                    onChanged:  (newValue) {

                      setState(() {
                        //print("runtime type: ${newValue.runtimeType}");
                        sampleId = newValue!;
                        // testSetupModal = sampleIdItems[sampleId] ?? TestSetupModal();
                        getsetData(sampleIdItems[sampleId] ?? TestSetupModal());
                      });
                    },
                  ),
                ),
              )
              // CommonDropDown(dropdownvalue: dropdownvalue,items:items,onChanged: (String? newValue) {
              //   setState(() {
              //     dropdownvalue = newValue!;
              //   });
              // })
            ],
          ),
        ),
        SizedBox(width: 100,),
        Column(
          children: [
            Row(
              children: [
                // CustomSmallButton(icon:Icons.refresh),
                // SizedBox(width: 10,),
                // CustomSmallButton(icon:Icons.chevron_right),
                // SizedBox(width: 10,),
                CustomSmallButton(icon:Icons.close,ontap: (){
                  showDialog(barrierDismissible: false,context: context,
                      builder: (context) => DailogBoxSystemCongif(text: 'You want to Close Test',
                        noOnTap: (){
                          Navigator.pop(context);
                        },yesOnTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );

                        },));
                }),
                SizedBox(width: 20,),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget getLeftConatiner(){
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      decoration: BoxDecoration(

        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(10),
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(text: 'MATERIAL INFORMATION',fontSize: 20,)
            ],
          ),
          SizedBox(height: 20,),
          CommonTextWithTextfeild(title: 'Sample ID',text: 'Sample id',controller:sampleIdController ,
              validator:  (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },),
          SizedBox(height: 20,),
          CommonTextWithTextfeild(title: 'Lot Number',text: 'Lot number',controller:lotNoController ,validator:
              (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },),
          SizedBox(height: 20,),
          CommonTextWithDropDown(dropdownvalue: testTrail , items: testTrailItems , title: 'Test Trial',
              onChanged:(String? newValue) {
                setState(() {
                  testTrail  = newValue!;
                });}),
          SizedBox(height: 20,),

          Row(
            children: [
              Expanded(flex: 2,
                  child: CommonText(text: "Wetting Fluid",fontSize: 25,)),
              Expanded(flex: 3,
                child: CommonDropDown2(width:400,dropdownvalue: wettingFluids, items: wettingFluidsItemsTwo.map((e,_){
                  return MapEntry(
                    e,
                    DropdownMenuItem(
                        value: e,
                        child: Container(
                          child: Text("$e : $_"),
                        )),
                  );
                }).values.toList(),
                    onChanged: (newValue) {
                      setState(() {
                        print("new value: ${newValue}");
                        wettingFluids = newValue!;
                      });}),
              ),
            ],
          ),
      // CommonTextWithTextfeild(title: 'Wetting Fluid',text: 'Wetting Fluid',controller:wettingFluidController ,validator:
      //     (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter some text';
      //   }
      //   return null;
      // },),
          SizedBox(height: 20,),
          wettingFluids== "AddFluid"?
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CommonTextfeildwithGradient(
                text: 'Name',
                controller:addFluidNameController ,width: 150,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },),
              SizedBox(width: 10,),
              CommonText(text: ':'),
              SizedBox(width: 10,),
              CommonTextfeildwithGradient(
                text: 'Value',
                controller:addFluidValueController ,width: 150,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },),
              SizedBox(width: 10,),
              CustomButtom(text: 'Add',
                ontap: (){
                  print('object');
                  wettingFluidsItemsTwo.addEntries([
                    MapEntry(addFluidNameController.text,addFluidValueController.text),
                  ]);
                  wettingFluids="${addFluidNameController.text}";
                  dropDownBox!.addAll([{addFluidNameController.text.trim():addFluidValueController.text.trim()}]);
                  // dropDownBox!.put(dropDownBoxKey, {addFluidNameController.text.trim():addFluidValueController.text.trim()});
                  // dropDownBox!.add({dropDownBoxKey:{addFluidNameController.text:addFluidValueController.text}});
                  setState((){
                  });
                },),

            ],
          ):Container(),

          SizedBox(height: 25,),



        ],
      ),

    );
  }

  Widget getRightContainer(){
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 20,).copyWith(top: 20),

      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(10),
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
      ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               CommonText(text: 'TEST CONFIGURATION',fontSize: 20,)
             ],
           ),
           SizedBox(height: 20,),


           Row(
             children: [
               Expanded(
                   flex: 2,
                   child:   CommonTextWithDropDown(dropdownvalue: bptThershold , items: bptThersholditems , title: 'BPT Thershold',
                       onChanged:(String? newValue) {
                         setState(() {
                           bptThershold  = newValue!;
                         });}),),
               Expanded(
                   flex: 1,
                   child: Container()),
             ],
           ),
           SizedBox(height: 20,),
           Row(
             children: [
               Expanded(
                   flex: 2,
                   child: CommonIncreaseDecrease(title: 'BPT Accuracy',controller:BptAccuracyController,)),
               Expanded(flex: 1,
                   child: Container())
             ],
           ),
           SizedBox(height: 20,),
           Row(
             children: [
               Row(
                   children: [
                     CommonText(text: 'Test Pressure',fontSize: 25,),
                     SizedBox(width: 45,),
                   ],
                 ),
               Expanded(
                   child: Row(children: [
                 CommonTextfeildwithGradient(
                   inputformatters: [
                     FilteringTextInputFormatter.digitsOnly
                   ],
                   keyboard:TextInputType.number,controller: testPressureFirstValueController,width: 110,suffixicon:Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Padding(
                       padding:  EdgeInsets.only(right: 15),
                       child: CommonText(text: 'psi'),
                     ),
                   ],
                 ),
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Please enter some text';
                     }
                     return null;
                   },),
                 SizedBox(width: 10,),
                 CommonText(text: 'to',fontSize: 25,),
                 SizedBox(width: 10,),
                 CommonTextfeildwithGradient(controller: testPressureSecondValueController,width: 110,suffixicon:
                 Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Padding(
                       padding:  EdgeInsets.only(right: 15),
                       child: CommonText(text: 'psi'),
                     ),
                   ],
                 ),
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Please enter some text';
                     }
                     return null;
                   },
                   inputformatters: [
                     FilteringTextInputFormatter.digitsOnly
                   ],
                 )
               ],)),

             ],
           ),
           SizedBox(height: 20,),
           Row(
             children: [
               Expanded(
                   flex: 2,

                   child:
                   CommonTextWithTextfeild(title: 'Turtuosity',text: 'Turtuosity',controller:TurtuosityController ,
                     validator:  (value) {
                     if (value == null || value.isEmpty) {
                       return 'Please enter some text';
                     }
                     return null;
                   },),),
               Expanded(flex: 1,
                   child: Container())
             ],
           ),
           SizedBox(height: 50,),


         ],
       ),
    );
  }

  Widget getBottmContainer(){
    return   Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            InkWell(

                child: CustomButtom(text: 'NEXT',ontap:(){
                  if (Key.currentState!.validate()) {
                    Key.currentState!.save();
                    if(double.parse(testPressureFirstValueController.text) > double.parse(testPressureSecondValueController.text)){
                      // testPressureFirstValueController.clear();
                      // testPressureSecondValueController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar( behavior: SnackBarBehavior.floating,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: AppColors.lightBlueColor.withOpacity(0.8),

                          content: CommonText(text: 'frst value is smaller than second value',textAlign: TextAlign.center,color:Colors.white,fontSize: 20,),
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 70,
                              right: 300,
                              left: 300),),
                      );
                    }
                    else{
                      testSetupModal.lotNumber=lotNoController.text;
                      testSetupModal.bubblePointType=bptThershold;
                      testSetupModal.bubblePoint=double.tryParse(BptAccuracyController.text) ?? 0.0;
                      testSetupModal.testPressureone=double.tryParse(testPressureFirstValueController.text) ?? 0.0;
                      testSetupModal.testPressuretwo=double.tryParse(testPressureSecondValueController.text) ?? 0.0;
                      testSetupModal.wettingFluid = {};
                      testSetupModal.wettingFluid[wettingFluids]=wettingFluidsItemsTwo[wettingFluids];
                      // print("Testsetup model : ${firstBox!.toMap()}");



                      // testSetupModal.lotNumber=lotNoController.text;
                      //
                      firstBox!.put(sampleId, testSetupModal.toMap());
                      //
                      setState((){});
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }

                  }


                },horizonal: 70,vertical: 10,))
          ],
        ),
      ),
    );
  }
}
