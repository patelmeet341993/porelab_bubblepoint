import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/controller/hive_controller.dart';
import 'package:porelab_bubblepoint/folder_structure/folder_structure.dart';
import 'package:porelab_bubblepoint/views/commons/common_logo_container.dart';
import 'package:porelab_bubblepoint/views/commons/custom_smallbutton.dart';
import 'package:porelab_bubblepoint/views/commons/topheader.dart';
import 'package:porelab_bubblepoint/views/settings_screens/screens/system%20_config.dart';
import 'package:porelab_bubblepoint/views/test_setup/screens/test_setup.dart';
import 'package:provider/provider.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

import '../../../controller/provider/test_setup_provider.dart';
import '../../../hive.dart';
import '../../../modals/bubblePointModel.dart';
import '../../commons/custom_container.dart';
import '../../commons/dashboard_top_header.dart';
import '../../graphs/graph_view_page.dart';
import '../../quick_test/screens/quick_test.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<Map>? firstBox;
  BubblePointModel  bubblePointModel = BubblePointModel(
      ans: [
        578.5234966216216,3763.581428571427,-4506.393552631579,4969.262608695657,-5708.098500000003,7278.568085106381
      ],
      t: [
        6.0,7.0,7.0,8.0,8.0,9.0
      ]
  );



  @override
  void initState(){

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      firstBox = await HiveController().initialHive();
      setState((){});
    });
    //wettingFluids='Select Fluid';
  }
  @override
  Widget build(BuildContext context) {

    TestSetupProvider testSetupProvider=Provider.of<TestSetupProvider>(context);
    if(firstBox!=null){
      testSetupProvider.firstBox=firstBox;
    }
    return SafeArea(
        child: Scaffold(
          body: getbody(),
        )
    );
  }
  Widget getbody(){
    return Column(
      children: [
        Row(
          children: [
           Container(
               child: TopHeader(text: "HOME",)),
            Spacer(),
            CustomSmallButton(icon: Icons.question_mark,),
            SizedBox(width: 20,),
            CustomSmallButton(icon: Icons.arrow_forward_ios_outlined,),
            SizedBox(width: 20,),
            CustomSmallButton(icon: Icons.close,),
            SizedBox(width: 40,)
          ],
            ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonLogoContainer(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TestSetup()),
                      );
                    },
                      url: "assets/common/quick test icon wb.png"),
                  SizedBox(width: 110,),
                  CommonLogoContainer(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuickTest()),
                        );
                      },
                      url: "assets/common/icon 2.png"),
                  SizedBox(width: 110,),
                  CommonLogoContainer(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (Context) => FolderStructure()));
                      },
                      url: "assets/common/icon 4.png"),
                 // SizedBox(width: 20,),
                ],
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonLogoContainer(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return GraphViewPage(
                                bubblePointModel: bubblePointModel,
                              );
                            }
                            ));
                      },
                      url: "assets/common/icon 4 (1).png"),
                  SizedBox(width: 110,),
                  CommonLogoContainer(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SystemConfiguration()),
                        );
                      },
                      url: "assets/common/icon 5.png"),
                  SizedBox(width: 110,),
                  CommonLogoContainer(
                      onTap: (){},
                      url: "assets/common/icon 6.png"),
                ],
              )
            ],
          ),
        ),
        
      ],
    );
  }
}
