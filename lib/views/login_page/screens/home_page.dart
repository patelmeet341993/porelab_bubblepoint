import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/controller/hive_controller.dart';
import 'package:porelab_bubblepoint/views/commons/common_logo_container.dart';
import 'package:porelab_bubblepoint/views/commons/custom_smallbutton.dart';
import 'package:porelab_bubblepoint/views/commons/topheader.dart';
import 'package:porelab_bubblepoint/views/settings_screens/screens/system%20_config.dart';
import 'package:porelab_bubblepoint/views/test_setup/screens/test_setup.dart';
import 'package:provider/provider.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

import '../../../controller/provider/test_setup_provider.dart';
import '../../../hive.dart';
import '../../commons/custom_container.dart';
import '../../commons/dashboard_top_header.dart';
import '../../quick_test/screens/quick_test.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<Map>? firstBox;
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
            SizedBox(height: 100,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               SizedBox(width: 20,),
               ClipRRect(
                 borderRadius: BorderRadius.circular(100),
                 child: TouchRippleEffect(
                   onTap: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TestSetup()),
                          );
                      } ,
                     rippleColor: Colors.white,
                     rippleDuration: Duration(milliseconds: 500),
                     child: ClipRRect(
                         borderRadius: BorderRadius.circular(100),
                         child: CommonLogoContainer(url: "assets/common/quick test icon wb.png"))),
               ),
               ClipRRect(
                   borderRadius: BorderRadius.circular(100),
                   child: TouchRippleEffect(
                       onTap: (){
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => QuickTest()),
                         );
                       } ,
                       rippleColor: Colors.white,
                       rippleDuration: Duration(milliseconds: 500),
                       child: ClipRRect(
                           borderRadius: BorderRadius.circular(100),
                           child: CommonLogoContainer(url: "assets/common/icon 2.png")))),
               ClipRRect(
                   borderRadius: BorderRadius.circular(100),
                   child: TouchRippleEffect(
                       onTap: (){
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => SystemConfiguration()),
                         );
                       } ,
                       rippleColor: Colors.white,
                       rippleDuration: Duration(milliseconds: 500),
                       child: ClipRRect(
                           borderRadius: BorderRadius.circular(100),
                           child: CommonLogoContainer(url: "assets/common/icon 4.png")))),
               SizedBox(width: 20,),
             ],
           ),
        SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 20,),
            CommonLogoContainer(url: "assets/common/icon 4 (1).png"),
            CommonLogoContainer(url: "assets/common/icon 5.png"),
            CommonLogoContainer(url: "assets/common/icon 6.png"),
            SizedBox(width: 20,),
          ],
        )
        ],
    );
  }
}
