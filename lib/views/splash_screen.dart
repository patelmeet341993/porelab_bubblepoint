import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_boldtext.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/views/login_page/screens/login_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  startTime() async {
    var duration = Duration(seconds: 4);
    await Future.delayed(duration);
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: getBody(),
      ),
    );
  }
  Widget getBody(){


    return Container(
      padding: EdgeInsets.only(left: 10,bottom: 20),
      height: MediaQuery.of(context).size.height,width:MediaQuery.of(context).size.width ,
      decoration: BoxDecoration(

          image: DecorationImage(
              image:AssetImage("assets/common/backsplash.png"),
              fit: BoxFit.cover
          )
      ),
      child: Column(

        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CommonText(text: 'v'),
              CommonText(text: '4.3',fontSize: 20,),
              SizedBox(width: 10,)
            ],
          ),
          Image.asset('assets/common/logo.png',height: 200,width: 800,),
          Divider(indent: 450,endIndent: 450,color: AppColors.whiteColor,thickness: 3,),
          CommonBoldText(text: 'Bubble Point Analyzer',fontSize: 30,fontWeight: FontWeight.w500,),
          Spacer(),
          Container(
            child: Row(
              children: [
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CommonText(text: '(c) Copywrite M19 Lab contributors 2019. All right reserved'),
                    CommonText(text: 'M19 Lab. We test the performance of the product Our'),
                    CommonText(text: 'Advanced lab technology and hands on supports help clients'),
                    CommonText(text: 'make product breathrough'),

                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Row(
                      children: [
                        CommonText(text: 'initializaton'),
                        SizedBox(width: 10,),

      SpinKitThreeInOut(
        size: 50.0,
        duration: Duration(milliseconds: 100),
        itemBuilder: (context,index){
          final colors=[AppColors.lightBlueColor,AppColors.whiteColor];
          final color=colors[index % colors.length];
          return DecoratedBox(decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle

          ));
        },
      )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
