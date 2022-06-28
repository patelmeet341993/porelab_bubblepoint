import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

import '../../commons/common_increasedecrease.dart';
import '../../commons/common_textandtextfeild.dart';
import '../../commons/common_textandtextfeild.dart';
import '../../commons/dashboard_top_header.dart';
import '../../commons/topheader.dart';
class QuickTest extends StatefulWidget {
  const QuickTest({Key? key}) : super(key: key);

  @override
  State<QuickTest> createState() => _QuickTestState();
}

class _QuickTestState extends State<QuickTest> {

  String dropdownvalue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String bptThershold = 'First Bubble';
  var bptThersholditems = [
    'First Bubble',
    'Moderate',
    'Countious',
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
  TextEditingController TurtuosityController=TextEditingController();
  TextEditingController lotNoController=TextEditingController();
  TextEditingController bptThresholdController=TextEditingController();
  TextEditingController BptAccuracyController=TextEditingController();
  TextEditingController testAccuracyController=TextEditingController();
  TextEditingController dataStabilityController=TextEditingController();
  TextEditingController testPressureFirstValueController=TextEditingController();
  TextEditingController testPressureSecondValueController=TextEditingController();
  final Key = GlobalKey<FormState>();
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
              Navigator.pop(context);
            },)
          ],
        ),
        SizedBox(width: 30,),
        Expanded(
          child: Column(
            children: [
              CommonDropDown(dropdownvalue: dropdownvalue,items:items,onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              })
            ],
          ),
        ),
        SizedBox(width: 100,),
        Column(
          children: [
            Row(
              children: [
                CustomSmallButton(icon:Icons.refresh),
                SizedBox(width: 10,),
                CustomSmallButton(icon:Icons.chevron_right),
                SizedBox(width: 10,),
                CustomSmallButton(icon:Icons.close),
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
          CommonTextWithDropDown(dropdownvalue: wettingFluid , items: wettingFluidItems , title: 'Wetting Fluid',
              onChanged:(String? newValue) {
                setState(() {
                  wettingFluid = newValue!;
                });}),
          SizedBox(height: 20,),
          // CommonTextWithTextfeild(title: 'Turtuosity',text: 'Turtuosity',controller:TurtuosityController ,
          //   validator:  (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Please enter some text';
          //   }
          //   return null;
          // },),
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
                   child:  CommonTextWithDropDown(dropdownvalue: bptThershold , items: bptThersholditems , title: 'BPT threshold',
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

                   child: CommonIncreaseDecrease(title: 'BPT Accuracy',controller:BptAccuracyController ,)),
               Expanded(flex: 1,
                   child: Container())
             ],
           ),
           SizedBox(height: 20,),
           Row(
             children: [
               Expanded(
                   flex: 3,

                   child:  Row(
                     children: [
                       CommonText(text: 'Test Pressure',fontSize: 25,),
                       SizedBox(width: 45,),
                       CommonTextfeildwithGradient(
                         inputformatters: [
                           FilteringTextInputFormatter.digitsOnly
                         ],
                         keyboard:TextInputType.number,controller: testPressureFirstValueController,width: 120,suffixicon:Column(
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
                       SizedBox(width: 20,),
                       CommonText(text: 'to',fontSize: 25,),
                       SizedBox(width: 20,),
                       CommonTextfeildwithGradient(controller: testPressureSecondValueController,width: 120,suffixicon:
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
                     ],
                   ),),
               Expanded(flex: 1,
                   child: Container())
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
                    if(int.parse(testPressureFirstValueController.text) > int.parse(testPressureSecondValueController.text)){
                      // testPressureFirstValueController.clear();
                      // testPressureSecondValueController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('First value must be smaller then second value')),
                      );
                    }
                    else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }

                  }


                },))
          ],
        ),
      ),
    );
  }
}
