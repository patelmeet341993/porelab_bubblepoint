import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/views/commons/common_dropdown.dart';
import 'package:porelab_bubblepoint/views/commons/common_radio.dart';
import 'package:porelab_bubblepoint/views/commons/common_textandtextfeild.dart';
import 'package:porelab_bubblepoint/views/commons/common_textwithdropdown.dart';
import 'package:porelab_bubblepoint/views/commons/dashboard_top_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import '../../commons/common_textfeildwith_gradient.dart';
import '../../commons/custom_button.dart';
import '../../commons/custom_smallbutton.dart';
import '../../commons/topheader.dart';
import '../../login_page/screens/home_page.dart';
import 'dailog_box.dart';
enum Pages{
  SampleIdWholePage,
  IndustryTypePage,
  MaterialTypePage,
  ShapeTypePage,
  TortusityPage,
  SizePage,

}

class TestSetup extends StatefulWidget {
  const TestSetup({Key? key}) : super(key: key);

  @override
  State<TestSetup> createState() => _TestSetupState();
}

class _TestSetupState extends State<TestSetup> {

  Pages selectedEnum = Pages.SampleIdWholePage;

  Widget update(Pages  pages){
    if(pages==Pages.SampleIdWholePage){
      return getSampleIdWholePage();
    }
    else if(pages==Pages.IndustryTypePage){
      return getIndustryTypePage();
    }
    else if(pages==Pages.MaterialTypePage){
      return getMaterialTypePage();
    }
    else if(pages==Pages.ShapeTypePage){
      return getShapeTypePage();
    }
    else if(pages==Pages.TortusityPage){
      return getTortusityPage();
    }
    else if(pages==Pages.SizePage){
      return getSizePage();
    }
    else{
      return Container();
    }
  }


  Widget imageUpdate(double value){
    if(value==0.1){
      return Image.asset("assets/common/0.1 n.png",height: 300,width: 450,);
    }
    else if(value==0.2){
      return Image.asset("assets/common/0.2 n.png",height: 300,width: 450,);
    }
    else if(value==0.3){
      return Image.asset("",height: 300,width: 450,);
    }
    else if(value==0.4){
      return Image.asset("assets/common/0.4.png",height: 300,width: 450,);
    }
    else if(value==0.5){
      return Image.asset("assets/common/0.5 n.png",height: 300,width: 450,);
    }
    else if(value==0.6){
      return Image.asset("assets/common/0.6 n.png",height: 300,width: 450,);
    }
    else if(value==0.7){
      return Image.asset("assets/common/0.7.png",height: 300,width: 450,);
    }
    else if(value==0.8){
      return Image.asset("assets/common/0.8 N.png",height: 300,width: 450,);
    }
    else if(value==0.9){
      return Image.asset("assets/common/0.9.png",height: 300,width: 450,);
    }
    else if(value==1.0){
      return Image.asset("assets/common/scaling brush 1.png",height: 300,width: 450,);
    }
    else{
      return Image.asset("assets/common/0.1 n.png",height: 300,width: 450,);
    }
  }

  String sampleId= 'Item 1';
  var sampleIdItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String trails= 'Item 1';
  var trailsItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String industryTypes= 'Item 1';
  var industryTypesItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String materialAppilcation= 'Item 1';
  var materialAppilcationItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String wettingFluids= 'Item 1';
  var wettingFluidsItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  int materialType=1;

  final tortusityKey = GlobalKey<FormState>();
  final sizeKey = GlobalKey<FormState>();
  final sampleIdKey = GlobalKey<FormState>();

  TextEditingController sampleProfileController=TextEditingController();
  TextEditingController lotNumberController=TextEditingController();
  TextEditingController enterRangeController=TextEditingController();
  TextEditingController thicknessController=TextEditingController();

  int select=0;
  int selectt=0;
  int sizeSelect=0;
  double currentSliderValue=0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: getbody()
      ),
    );
  }
  Widget getbody(){
    return Column(
      children: [
        topHeader(),
        SizedBox(height: 60,),
        getProgressIndicator(),
        SizedBox(height: 100,),
       update(selectedEnum)

      ],
    );
  }

  Widget topHeader(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TopHeader(show:true,icon:Icons.arrow_back_ios_outlined ,text: "TEST SETUP",ontap: (){
          Navigator.pop(context);
        },),
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
    );
  }

   int curentStep =0;

  Widget getProgressIndicator(){
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //       color: AppColors.whiteColor,
            //       blurRadius: 1.0,
            //       spreadRadius:0.3,
            //     offset: Offset(0, -4),
            //
            //   ),
            // ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 200),
          child: StepProgressIndicator(
            totalSteps: 100,
            currentStep: curentStep,
            size: 50,
            padding: 0,
            // selectedColor: Colors.yellow,
            unselectedColor: AppColors.blackColor,
            roundedEdges: Radius.circular(10),
            selectedGradientColor: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.lightBlueColor, AppColors.whiteColor],
            ),
          ),
        ),
       getPositionedCircle(190),
        getPositionedCircle(760),
        getPositionedCircle(1290),
      ],
    );
  }

  Widget getSampleIdWholePage(){
    return  Form(
      key: sampleIdKey,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        child: Column(
          children: [
            getsampleId(),
            SizedBox(height: 150,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButtom(text: 'NEXT',
                  ontap: (){

                    if (!sampleIdKey.currentState!.validate()) {
                      sampleIdKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('error')),
                      );
                    }
                    else{
                       selectedEnum=Pages.IndustryTypePage;
                    }
                    setState((){
                    });
                },)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getsampleId(){
    return   Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(

            padding: EdgeInsets.only(left: 250),

            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: CommonText(text:"Sample ID",fontSize: 25,)),
                    // Expanded(
                    //     flex: 3,
                    //     child: CommonDropDown(dropdownvalue:widget.dropdownvalue , items:widget.items,onChanged:widget.onChanged , )
                    // )
                    // Expanded(
                    //   child: CommonTextWithDropDown(dropdownvalue: sampleId, items: sampleIdItems, title: 'Sample ID', onChanged: (String? newValue) {
                    //     setState(() {
                    //       sampleId = newValue!;
                    //     });
                    //   }),
                    // ),

                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                        child: CommonTextWithTextfeild(text: 'Sample profile', title: 'Sample profile', controller: sampleProfileController,
                        validator:(value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },)
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                        child: CommonTextWithTextfeild(text: 'Lot Number', title: 'Lot Number', controller: lotNumberController,
                          validator:(value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },)
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(

            padding: EdgeInsets.symmetric(horizontal: 30),
            height: 150,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(

                    children: [
                      SizedBox(height: 40,),
                      CommonText(text: 'Trails'),


                      CommonDropDown(dropdownvalue: trails, items: trailsItems, onChanged: (String? newValue) {
                        setState(() {
                          trails = newValue!;
                        });
                      }),

                    ],
                  ),
                ),
                Expanded(flex:4,child: Container())
              ],
            ),

          ),
        ),

      ],
    );
  }

  Widget getPositionedCircle(double left){
    return  Positioned(
       left: left,
        top: -7,
        child:
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: LinearGradient(
                stops: [0.03,.4],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.whiteColor,
                  AppColors.blackColor
                ]),
          ),
          height: 60,
          width: 60,

        ));
  }

  Widget getIndustryTypePage(){
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(right: 600),
                  padding: EdgeInsets.only(left: 250),
                  child: Column(
                    children: [
                        CommonTextWithDropDown(dropdownvalue: industryTypes, items: industryTypesItems, title: 'Industry Type', onChanged:
                            (String? newValue) {
                          setState(() {
                            industryTypes = newValue!;
                          });
                        }),
                      SizedBox(height: 20,),
                      CommonTextWithDropDown(dropdownvalue: materialAppilcation, items: materialAppilcationItems, title: 'Material Application', onChanged:
                          (String? newValue) {
                        setState(() {
                          materialAppilcation = newValue!;
                        });
                      }),
                    ]
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 210,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButtom(text: 'BACK',
                ontap: (){
                  selectedEnum=Pages.SampleIdWholePage;
                  setState((){

                  });
                },),
              SizedBox(width: 40,),
              CustomButtom(text: 'NEXT',
                ontap: (){
                  selectedEnum=Pages.MaterialTypePage;
                  setState((){
                  });
                },)
            ],
          )
        ],
      ),
    );
  }

  Widget getMaterialCard({  required String  text, Function() ? onTap, int Selected=0}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:EdgeInsets.only(right: 20),
        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: select==Selected ? AppColors.lightBlueColor:AppColors.whiteColor
        ),
        child:Column(
          children: [
            Image.asset("assets/common/img.png",height: 100,),
            SizedBox(height: 20,),
            CommonText(color: AppColors.blackColor,text: text,fontSize: 20,)
          ],
        ),
      ),
    );
  }

  Widget getMaterialTypePage(){
    return Container(
      // color: Colors.orange,
      margin: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             getMaterialCard(text: 'Fibrous',onTap: (){
               select=0;
               setState((){
               });
             },Selected:0),
             getMaterialCard(text: 'Coated',onTap: (){
                select=1;
                setState((){
                });
                },Selected:1),
             getMaterialCard(text: 'Consolidate',onTap: (){
             select=2;
             setState((){
             });
             },Selected:2),
             getMaterialCard(text: 'Laminated',onTap: (){
              select=3;
              setState((){
              });
              },Selected:3),
             getMaterialCard(text: 'Unknown',onTap: (){
              select=4;
              setState((){
              });
              },Selected:4)
           ],
         ),
          SizedBox(height: 77,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButtom(text: 'BACK',
                ontap: (){
                  selectedEnum=Pages.IndustryTypePage;
                  setState((){

                  });
                },),
              SizedBox(width: 40,),
              CustomButtom(text: 'NEXT',
                ontap: (){
                  selectedEnum=Pages.ShapeTypePage;
                  setState((){

                  });
                },),
              SizedBox(width: 20,),
            ],
          )
        ],
      ),
    );
  }

  Widget getShapeCard({  required String  text, Function() ? onTap, int Selected=0,required String url}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        margin:EdgeInsets.only(right: 20),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: selectt==Selected ? AppColors.lightBlueColor:AppColors.whiteColor
        ),
        child:Column(
          children: [
            Image.asset(url,height: 80,width: 80,),
            SizedBox(height: 20,),
            CommonText(color: AppColors.blackColor,text: text,fontSize: 20,)

          ],
        ),
      ),
    );
  }

  Widget getShapeTypePage(){
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getShapeCard(text: 'Triangular',onTap: (){
                selectt=0;
                setState((){
                });
              },Selected:0,url: "assets/common/t.png"),

              getShapeCard(text: 'Rectangular',onTap: (){
                selectt=1;
                setState((){
                });
              },Selected:1,url: "assets/common/rectangular.png"),

              getShapeCard(text: 'Circle',onTap: (){
                selectt=2;
                setState((){
                });
              },Selected:2,url: "assets/common/circular .png"),

              getShapeCard(text: 'Elliptical',onTap: (){
                selectt=3;
                setState((){
                });
              },Selected:3,url: "assets/common/elliptical .png"),

              getShapeCard(text: 'Square',onTap: (){
                selectt=4;
                setState((){
                });
              },Selected:4,url: "assets/common/square.png"),

              getShapeCard(text: 'Slit',onTap: (){
                selectt=5;
                setState((){
                });
              },Selected:5,url: "assets/common/slit .png",),

              getShapeCard(text: 'Unknown',onTap: (){
                selectt=6;
                setState((){
                });
              },Selected:6,url: "assets/common/t.png")

            ],
          ),
          SizedBox(height: 50,),
          Container(
            padding: EdgeInsets.only(left: 200),
            child: Row(
              children: [
                CommonText(text: 'MATERIAL TYPE',fontSize:25 ,),
                SizedBox(width: 20,),
                Expanded(
                  child: CommonRadio(onChanged:  (int ? value){
                    setState(() {
                      materialType = value!;
                    });
                  }, valued: materialType, text1: 'Hydrophilic', text2: 'Hydrophobic', text3: 'Unknown'),
                ),
      Expanded(
            flex: 1,
            child: Container())
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButtom(text: 'BACK',
                ontap: (){
                  selectedEnum=Pages.MaterialTypePage;
                  setState((){

                  });
                },),
              SizedBox(width: 40,),
              CustomButtom(text: 'NEXT',
                ontap: (){
                  selectedEnum=Pages.TortusityPage;
                  setState((){

                  });
                },),
              SizedBox(width: 20,),

            ],
          )
        ],
      ),
    );
  }

   Widget getTortusityPage(){
    return Form(
      key:tortusityKey ,
      child: Container(
       // color: Colors.red,
        child:Column(
          children: [
          Row(
            children: [
             Expanded(
                 child: Container(
                   child: Column(
               children: [
                   ClipRRect(
              borderRadius: BorderRadius.circular(30),
                     child: Container(
                         decoration: BoxDecoration(

                           borderRadius: BorderRadius.circular(30)
                         ),
                         child:  imageUpdate(currentSliderValue)),
                   )
               ],

             ),
                 )
             ),
             Expanded(
                 child: Container(
                   height: 300,
                   margin: EdgeInsets.symmetric(horizontal: 20),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       CommonText(text: 'What is the Turtosity Factor Of Trial ?',color: AppColors.whiteColor,fontSize: 25,),
                       SizedBox(height: 20,),
                       Container(
                         padding: EdgeInsets.symmetric(horizontal: 10),
                         decoration: BoxDecoration(
                             border: Border.all(color: AppColors.whiteColor),
                           borderRadius: BorderRadius.circular(100),
                         ),
                           child:
                               Row(
                                 children: [
                                   Icon(Icons.horizontal_rule,color: AppColors.whiteColor,),
                                   Expanded(
                                     child: Slider(
                                       // value: double.parse(enterRangeController.text),
                                       value: currentSliderValue,
                                       min: 0,
                                       max: 1,
                                       divisions: 10,
                                      activeColor: AppColors.lightBlueColor,
                                      inactiveColor: AppColors.whiteColor,
                                      thumbColor: AppColors.blackColor,
                                      // label: currentSliderValue.round().toString(),
                                      label: enterRangeController.text,
                                      // label: enterRangeController.text,
                                       onChanged: (double value) {
                                         setState(() {
                                            currentSliderValue = value;
                                           enterRangeController.text = value.toString();

                                         });
                                       },
                                     ),
                                   ),
                                   Icon(Icons.add,color: AppColors.whiteColor,),
                                 ],
                               )

                         ),
                       SizedBox(height: 20,),
                       Row(
                         children: [
                           CommonText(text: 'ENTER 0 TO 1'),
                           SizedBox(width: 20,),
                           Container(
                             width: 130,
                             height: 45,
                             decoration: BoxDecoration(
                               color: AppColors.blackColor,
                                 borderRadius: BorderRadius. circular(100.0),
                                 boxShadow: [
                                   BoxShadow(
                                     color: AppColors.whiteColor.withOpacity(0.2),
                                     offset:  Offset(
                                       -2.0,
                                       -2.0,
                                     ),
                                     blurRadius: 1.0,
                                     spreadRadius: 2.0,
                                   ),]
                             ),//BoxS
                             child: TextFormField(
                               onChanged: (value){
                                 currentSliderValue=double.parse(value);
                                 setState(() {});
                               },
                               keyboardType:TextInputType.number,
                               controller: enterRangeController,
                               inputFormatters: [
                                 FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                                 TextInputFormatter.withFunction((oldValue, newValue) {
                                   try {
                                     final text = newValue.text;
                                     if (text.isNotEmpty) double.parse(text);
                                     return newValue;
                                   } catch (e) {}
                                   return oldValue;
                                 }),
                               ],
                               validator: (value) {
                                 if (value == null || value.isEmpty) {
                                   return 'Please enter number';
                                 }
                                 return null;
                               },

                               style: TextStyle(color: AppColors.whiteColor),
                               cursorColor: AppColors.whiteColor,
                               decoration: InputDecoration(

                                 counterStyle: TextStyle(color: AppColors.whiteColor),
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius. circular(100.0),
                                 ),
                                 fillColor: Colors.transparent,
                                 filled: true,
                                 contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                 focusedErrorBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
                                 errorBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
                                 focusedBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
                                 enabledBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
                               ),
                             ),
                           )
                         ],
                       )
                     ],

             ),
                 )
             )
            ],
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButtom(text: 'BACK',
                  ontap: (){
                    selectedEnum=Pages.ShapeTypePage;
                    setState((){

                    });
                  },),
                SizedBox(width: 40,),
                CustomButtom(text: 'NEXT',
                  ontap: (){
                    if (tortusityKey.currentState!.validate()) {

                      tortusityKey.currentState!.save();
                      if(!(0<=double.parse(enterRangeController.text)&&double.parse(enterRangeController.text)<=1)){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('error')),
                        );
                      }
                      else{
                        selectedEnum=Pages.SizePage;
                      }
                    }
                    setState((){
                    });
                  },),
                SizedBox(width: 20,),

              ],
            )
          ],
        ) ,
      ),
    );
   }

  Widget getSizeCard({  required String  text, Function() ? onTap, int Selected=0,required String url}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        margin:EdgeInsets.only(right: 20),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: sizeSelect==Selected ? AppColors.lightBlueColor:AppColors.whiteColor
        ),
        child:Column(
          children: [
            Image.asset(url,height: 80,width: 80,),
            SizedBox(height: 20,),
            CommonText(color: AppColors.blackColor,text: text,fontSize: 20,)

          ],
        ),
      ),
    );
  }

  Widget getSizePage(){
    return Form(
      key: sizeKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
              Expanded(
                flex: 2,
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getSizeCard(text: 'Small',onTap: (){
                      sizeSelect=0;
                      setState((){
                      });
                    },Selected:0,url: "assets/common/small.png"),
                    getSizeCard(text: 'Medium',onTap: (){
                      sizeSelect=1;
                      setState((){
                      });
                    },Selected:1,url: "assets/common/small.png"),
                    getSizeCard(text: 'Large',onTap: (){
                      sizeSelect=2;
                      setState((){
                      });
                    },Selected:2,url: "assets/common/large.png"),
                  ],
                )
                ],
              )
              )  ,
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         CommonText(text: "Enter Sample Thickness",fontSize: 25,),
                        CommonTextfeildwithGradient(controller: thicknessController,width: 400,suffixicon:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(right: 30),
                              child: CommonText(text: 'mm'),
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
                            FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                            TextInputFormatter.withFunction((oldValue, newValue) {
                              try {
                                final text = newValue.text;
                                if (text.isNotEmpty) double.parse(text);
                                return newValue;
                              } catch (e) {}
                              return oldValue;
                            }),
                          ],
                        ),
                        SizedBox(height: 20,),
                        CommonText(text: "Select Wetting Fluid",fontSize: 25,),
                        CommonDropDown(width:400,dropdownvalue: wettingFluids, items: wettingFluidsItems, onChanged: (String? newValue) {
                          setState(() {
                            wettingFluids = newValue!;
                          });})

                      ],
                    )
                )
              ],
            ),
            SizedBox(height: 98,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButtom(text: 'BACK',
                  ontap: (){
                    selectedEnum=Pages.TortusityPage;
                    setState((){

                    });
                  },),
                SizedBox(width: 40,),
                CustomButtom(text: 'NEXT',
                  ontap: (){
                    if (!sizeKey.currentState!.validate()) {
                      sizeKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('error')),
                      );

                    }
                    else{

                      showDialog(context: context, builder: (context) =>DailogBox());

                    }
                    setState((){
                    });
                  },),


              ],
            ),
          ],
        )
      ),
    );
  }




}
