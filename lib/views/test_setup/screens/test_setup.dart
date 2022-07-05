import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/controller/provider/test_setup_provider.dart';
import 'package:porelab_bubblepoint/modals/test_setup_modal.dart';
import 'package:porelab_bubblepoint/utils/hive_manager.dart';
import 'package:porelab_bubblepoint/views/commons/common_dropdown.dart';
import 'package:porelab_bubblepoint/views/commons/common_radio.dart';
import 'package:porelab_bubblepoint/views/commons/common_textandtextfeild.dart';
import 'package:porelab_bubblepoint/views/commons/common_textwithdropdown.dart';
import 'package:porelab_bubblepoint/views/commons/dashboard_top_header.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import '../../../config/constants.dart';
import '../../../controller/hive_controller.dart';
import '../../../hive.dart';
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
  SelectBubblePoint,
  BubblePintSlider
}

class TestSetup extends StatefulWidget {
  const TestSetup({Key? key}) : super(key: key);

  @override
  State<TestSetup> createState() => _TestSetupState();
}

class _TestSetupState extends State<TestSetup> {

  Pages selectedEnum = Pages.SampleIdWholePage;

  TestSetupProvider? testSetupProvider;

  String? sampleId;

  Map<String,TestSetupModal> sampleIdItems={};

  String trails= 'Item 1';
  var trailsItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  Map<String,List<String>> myMap={

    "Select Industry Type":["Select Material Application"],

    "Biotech":["Tissue", "Bandage", "Implant", "Body Part", "Filter", "Skin"],

    "Textile":["Geotextiles", "Bullet Proof Vests", "Space suits",
      "Automotive", "Medical", "Nanotechnology",
      "Construction", "Agrotextiles", "Packaging",
      "Sports"],

    "Non-woven & Paper":["Aeronautical", "Automotive", "Construction",
      "Filtration", "Medical", "Agriculture",
      "Home Furnishing", "Clothing", "Geo textiles",
      "Coated Paper", "Packaging", "Felt"],

    "Filtration":["Felts", "Wire Mesh", "Textiles", "Perforated",
      "water filter", "air filter", "oil filter",
      "Minipleat HEPA Filters", "Rigidpack",
      "Multiwedge", "Grease Filter", "Carbon Panel",
      "Eco Bag Filter", "Carbon CF Filter", "Cartridge",
      "Strainers", "Hydraulic Filters"],

    "Pharma":["Powdered Drugs", "Packaging materials", "Pouches"],

    "Polymer":["ABS (Acrylonitrile-butadiene-styrene)",
      "Acrylics(poly-methyl-methacrylate)",
      "Fluorocarbons(PTFE or TFE)", "Polycarbonates",
      "Polyethylene", "Polypropylene", "Polystyrene",
      "Polyester", "Epoxies", "Phenolics"],

    "Battery":["battery separators"],

    "Packaging":["liquid", "solid", "moisture"],

    "Enviroment & Hygene":["Diapers", "Tissues", "Paper towel", "Sheets",
      "Cosmetics"],

    "Chemical":["Zeolites", "Catalysts", "Carbon black",
      "Abrasives", "Fertilizers", "Metal powders"],

    "Ceramics":["Automotive", "Electronics", "Filtration",
      "Aerospace", "Composites", "Coatings", "Implants",
      "Enviromental", "Chemical"],

    "Acoustics":["Foams", "Barriers",
      "Composites", "Diffusers",
      "Ceiling Baffles", "Fiber Glass",
      "Blankets", "Wall Panels", "Automotive",
      "Aircraft", "Building"],

    "Other":[ "Other"]

  };

  String industryTypes= "Select Industry Type";
  String materialCardext='Fibrous';
  String shapeCardext='Triangular';
  String sizeCardext='Small';
  String bubblePointCardText='First Bubble';

  String materialAppilcation= '';
  // Map<String,String> wettingFluids={};
  String wettingFluids = "Water";
  // List<String>  wettingFluidsItems=[
  //   'Add Fluid',
  //   'Water:72.0',
  //   'MineralOil:34.7',
  //   'PetroleumDistillate:30.0',
  //   'DenaturedAlcohol:22.3',
  //   'Porewick:16.0',
  //   'Galwick:15.9',
  // ];

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

  String materialType='Hydrophilic';

  final tortusityKey = GlobalKey<FormState>();
  final sizeKey = GlobalKey<FormState>();
  final sampleIdKey = GlobalKey<FormState>();
  final BubblePointSliderKey = GlobalKey<FormState>();


  TextEditingController sampleProfileController=TextEditingController();
  TextEditingController lotNumberController=TextEditingController();
  TextEditingController turtosityController=TextEditingController();
  TextEditingController thicknessController=TextEditingController();
  TextEditingController testPressureFirstValueController=TextEditingController();
  TextEditingController testPressureSecondValueController=TextEditingController();
  TextEditingController addFluidNameController=TextEditingController();
  TextEditingController addFluidValueController=TextEditingController();

  TestSetupModal testSetupModal=TestSetupModal();



  int bubblepointselect=0;
  double currentSliderValue=0;
  double currentSliderValue2=0;

  Box<Map>? firstBox,dropDownBox;

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
    else if(pages==Pages.SelectBubblePoint){
      return getselectBubblePoint();
    }
    else if(pages==Pages.BubblePintSlider){
      return getBubblePointSlider();
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
      return Image.asset("assets/common/0.3 n.png",height: 300,width: 450,);
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

  void getDropDownData() async {
    dropDownBox = await HiveController().initialHivetwo();
    // dropDownBox!.clear();
    // Map? value = dropDownBox!.get(dropDownBoxKey);
    dropDownBox!.values.forEach((element) {
      wettingFluidsItemsTwo.addAll(Map.castFrom<dynamic,dynamic,String,String>(element));
    });

    // wettingFluidsItemsTwo.addAll(Map.castFrom<dynamic,dynamic,String,String>(value!));
    print("dropdownmenu $dropDownBox");
  }

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

  void getsetData(TestSetupModal tSM){
    sampleProfileController.text=tSM.sampleProfile;
    lotNumberController.text=tSM.lotNumber;
    industryTypes=tSM.industryType;
    materialAppilcation=tSM.materialApplication;
    materialCardext=tSM.materialTypeCard;
    shapeCardext=tSM.shapeType;
    materialType=tSM.materialType;
    turtosityController.text=tSM.turtosity;
    sizeCardext=tSM.sizeType;
    thicknessController.text=tSM.thickness;
    // wettingFluids=tSM.wettingFluid;
    bubblePointCardText=tSM.bubblePointType;
    currentSliderValue2=tSM.bubblePoint;
    testPressureFirstValueController.text=tSM.testPressureone.toString();
    testPressureSecondValueController.text=tSM.testPressuretwo.toString();
    setState((){});
  }

  @override
  void initState(){
    sampleIdItems["select Project"]=TestSetupModal();
    materialAppilcation =myMap["Select Industry Type"]?.first ??'';
    getTestSetList();
    getDropDownData();


  }
  @override
  Widget build(BuildContext context) {
    TestSetupProvider testSetupProvider=Provider.of<TestSetupProvider>(context);
    if(firstBox!=null){
      testSetupProvider.firstBox=firstBox;
    }
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

                      testSetupModal.sampleProfile=sampleProfileController.text;
                      testSetupModal.lotNumber=lotNumberController.text;
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
                        child: CommonText(text: 'Sample ID',fontSize: 25,)),
                    Expanded(
                        flex: 3,
                        child: Container(
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
                                    getsetData(sampleIdItems[sampleId] ?? TestSetupModal());
                                  });
                                },
                            ),
                          ),
                        )
                    )

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
                // Expanded(
                //   flex: 1,
                //   child: Column(
                //
                //     children: [
                //       SizedBox(height: 40,),
                //       CommonText(text: 'Trails'),
                //
                //
                //       CommonDropDown(dropdownvalue: trails, items: trailsItems, onChanged: (String? newValue) {
                //         setState(() {
                //           trails = newValue!;
                //         });
                //       }),
                //
                //     ],
                //   ),
                // ),
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
                        CommonTextWithDropDown(dropdownvalue: industryTypes, items: myMap.keys.toList(), title: 'Industry Type', onChanged:
                            (String? newValue) {
                          setState(() {
                            industryTypes = newValue!;
                            materialAppilcation = myMap[industryTypes]?.first ?? '';
                          });
                        }),
                      SizedBox(height: 20,),
                      CommonTextWithDropDown(dropdownvalue: materialAppilcation, items: myMap[industryTypes] ?? [], title: 'Material Application', onChanged:
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
                  testSetupModal.industryType=industryTypes;
                  testSetupModal.materialApplication=materialAppilcation;
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

  Widget getMaterialCard({ required String  text, Function() ? onTap,required String url,}){
    return GestureDetector(
      onTap: (){
        onTap!();
        materialCardext=text;

      },
      child: Container(
        width: 170,
        margin:EdgeInsets.only(right: 20),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: materialCardext==text ? AppColors.lightBlueColor:AppColors.whiteColor
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
             getMaterialCard(url:"assets/common/fibrous.png",text: 'Fibrous',onTap: (){
               materialCardext;
               setState((){
               });
             }),
             getMaterialCard(url:"assets/common/coated.png",text: 'Coated',onTap: (){
               materialCardext;
                setState((){
                });
                },),
             getMaterialCard(url:"assets/common/consolidate.png",text: 'Consolidate',onTap: (){
               materialCardext;
             setState((){
             });
             }),
             getMaterialCard(url:"assets/common/laminated.png",text: 'Laminated',onTap: (){
               materialCardext;
              setState((){
              });
              }),
             getMaterialCard(url:"assets/common/m1_5.png",text: 'Unknown',onTap: (){
               materialCardext;
              setState((){
              });
              })
           ],
         ),
          SizedBox(height: 98,),
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
                  testSetupModal.materialTypeCard=materialCardext;
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

  Widget getShapeCard({  required String  text, Function() ? onTap,required String url}){
    return GestureDetector(
      onTap: (){
        onTap!();
        shapeCardext=text;

      },
      child: Container(
        width: 170,
        margin:EdgeInsets.only(right: 20),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: shapeCardext==text ? AppColors.lightBlueColor:AppColors.whiteColor
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

                setState((){
                });
              },url: "assets/common/t.png"),

              getShapeCard(text: 'Rectangular',onTap: (){

                setState((){
                });
              },url: "assets/common/rectangular.png"),

              getShapeCard(text: 'Circle',onTap: (){
                // selectt=2;
                setState((){
                });
              },
                  url: "assets/common/circular .png"),

              getShapeCard(text: 'Elliptical',onTap: (){
                // selectt=3;
                setState((){
                });
              },url: "assets/common/elliptical .png"),

              getShapeCard(text: 'Square',onTap: (){
                // selectt=4;
                setState((){
                });
              },url: "assets/common/square.png"),

              getShapeCard(text: 'Slit',onTap: (){
                // selectt=5;
                setState((){
                });
              },url: "assets/common/slit .png",),

              getShapeCard(text: 'Unknown',onTap: (){
                // selectt=6;
                setState((){
                });
              },url: "assets/common/m1_5.png")

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
                  child: CommonRadio(onChanged:  (String ? value){
                    setState(() {
                      materialType = value!;
                      // if(materialType==1)
                      // {
                      //   print('Hydrophilic');
                      // }
                      //   else if(materialType==2)
                      //   {
                      //   print('Hydrophobic');
                      // }
                      //   else{
                      //   print('Unknown');
                      // }
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
                  testSetupModal.shapeType=shapeCardext;
                  testSetupModal.materialType=materialType;

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
                                      label: turtosityController.text,
                                      // label: enterRangeController.text,
                                       onChanged: (double value) {
                                         setState(() {
                                            currentSliderValue = value;
                                            turtosityController.text = value.toString();

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
                               controller: turtosityController,
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
                      if(!(0<=double.parse(turtosityController.text)&&double.parse(turtosityController.text)<=1)){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('error')),
                        );
                      }
                      else{
                        testSetupModal.turtosity=turtosityController.text;
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
      onTap: (){
        onTap!();
        sizeCardext=text;
      },
      child: Container(
        width: 170,
        margin:EdgeInsets.only(right: 20),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: sizeCardext==text ? AppColors.lightBlueColor:AppColors.whiteColor
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

                      setState((){
                      });
                    },Selected:0,url: "assets/common/small.png"),
                    getSizeCard(text: 'Medium',onTap: (){
                      // sizeSelect=1;
                      setState((){
                      });
                    },Selected:1,url: "assets/common/small.png"),
                    getSizeCard(text: 'Large',onTap: (){
                      // sizeSelect=2;
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
                        Row(
                          children: [
                            CommonDropDown2(width:400,dropdownvalue: wettingFluids, items: wettingFluidsItemsTwo.map((e,_){
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
                             SizedBox(width: 15,),

                            !wettingFluidsItems.containsKey(wettingFluids)  ? InkWell(
                                onTap: (){
                                  wettingFluidsItems.remove(wettingFluids);
                                  wettingFluidsItemsTwo.remove(wettingFluids);
                                  wettingFluids = wettingFluidsItemsTwo.keys.first;
                                  // dropDown
                                  // print('object ${wettingFluidsItems.toString()}');
                                  // getDropDownData();
                                  setState((){});
                                },
                                child: Icon(Icons.delete,color: AppColors.lightBlueColor,)):Container()
                          ],
                        ),
                         SizedBox(height: 20,),
                         wettingFluids== "AddFluid"?
                         Row(
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
                         ):Container()
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
                      testSetupModal.sizeType =sizeCardext;
                      testSetupModal.thickness =thicknessController.text;
                      // testSetupModal.wettingFluid =wettingFluids;

                      selectedEnum=Pages.SelectBubblePoint;
                      // showDialog(context: context, builder: (context) =>DailogBox());

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

  Widget getBubblePointCard({  required String  text, Function() ? onTap,required String url}){
    return GestureDetector(
      onTap: (){
        onTap!();
        bubblePointCardText=text;
      },
      child: Container(
        width: 170,
        margin:EdgeInsets.only(right: 20),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: bubblePointCardText==text ? AppColors.lightBlueColor:AppColors.whiteColor
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

  Widget getselectBubblePoint(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CommonText(text: "Select Bubble Point Trigger",fontSize: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getBubblePointCard(url:"assets/common/First bubble.png",text: 'First Bubble',onTap: (){

                setState((){
                });
              }),
              getBubblePointCard(url:"assets/common/moderate n.png",text: 'Moderate',onTap: (){
                bubblepointselect=1; setState((){
                });
              }),
              getBubblePointCard(url:"assets/common/continous.png",text: 'Countinous',onTap: (){

                setState((){
                });
              }),

            ],
          ),
          SizedBox(height: 80,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButtom(text: 'BACK',
                ontap: (){
                  selectedEnum=Pages.SizePage;
                  setState((){
                  });
                },),
              SizedBox(width: 40,),
              CustomButtom(text: 'NEXT',
                ontap: (){
                  testSetupModal.bubblePointType =bubblePointCardText;
                  selectedEnum=Pages.BubblePintSlider;
                  setState((){

                  });
                },
              ),



            ],
          ),
        ],
      ),
    );
  }

  Widget getBubblePointSlider(){
    return Form(
      key:BubblePointSliderKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 100,),

                // Expanded(child: Container(color: Colors.green,)),
                CommonText(text: 'Bubble Point',fontSize: 20,),
                SizedBox(width: 50,),
                Container(
                  width: 800,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.whiteColor),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    children: [
                     CommonText(text: 'Fast'),
                      Expanded(
                        child: Slider(
                          value: currentSliderValue2,
                          max: 100,
                          divisions: 20,
                          activeColor: AppColors.lightBlueColor,
                          inactiveColor: AppColors.whiteColor,
                          thumbColor: AppColors.blackColor,
                          label: currentSliderValue2.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              currentSliderValue2 = value;
                            });
                          },
                        ),
                      ),
                      CommonText(text: 'Accurate'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 100,),
                // Expanded(child: Container(color: Colors.green,)),
                CommonText(text: 'Test Pressure',fontSize: 20,),
                SizedBox(width: 50,),
                CommonTextfeildwithGradient(
                  inputformatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboard:TextInputType.number,controller: testPressureFirstValueController,width: 150,suffixicon:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(right: 30),
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
                CommonTextfeildwithGradient(controller: testPressureSecondValueController,width: 150,suffixicon:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(right: 30),
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
            ),
            SizedBox(height: 189,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButtom(text: 'BACK',
                  ontap: (){
                    selectedEnum=Pages.SelectBubblePoint;
                    setState((){
                    });
                  },),
                SizedBox(width: 40,),
                CustomButtom(text: 'NEXT',
                  ontap: (){
                    if (BubblePointSliderKey.currentState!.validate()) {
                      BubblePointSliderKey.currentState!.save();
                      if (int.parse(testPressureFirstValueController.text) >
                          int.parse(testPressureSecondValueController.text)) {
                        testPressureFirstValueController.clear();
                        testPressureSecondValueController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(
                              'First value must be smaller then second value')),
                        );
                      }
                      else {
                        testSetupModal.bubblePoint = currentSliderValue2;
                        testSetupModal.testPressureone = double.tryParse(testPressureFirstValueController.text) ?? 0.0;
                        testSetupModal.testPressuretwo = double.tryParse(testPressureSecondValueController.text) ?? 0.0;
                        showDialog(context: context,
                            builder: (context) => DailogBox(testSetupModal: testSetupModal));
                      }
                      setState(() {});
                    }}),



              ],
            ),
          ],
        ),
      ),
    ) ;
  }




}
