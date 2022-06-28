
import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/hive.dart';
import 'package:porelab_bubblepoint/utils/hive_manager.dart';
import 'package:porelab_bubblepoint/views/commons/custom_button.dart';
import 'package:porelab_bubblepoint/views/login_page/screens/home_page.dart';

import '../../../config/common_boldtext.dart';
import '../../commons/common_textfeild.dart';
import '../../commons/custom_smallbutton.dart';
import '../../commons/topheader.dart';class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController= TextEditingController();
  TextEditingController  passwordController= TextEditingController();

  @override
  void initState(){
    HiveManager().initMethodHive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body:getbody()
        ));
  }
  Widget getbody(){
    return Column(
      children: [

        getTopHeader(),
        Expanded(
          child: Row(
            children: [
              getLoginSide(),
              getImageSide()
            ],
          ),
        ),
      ],
    );
  }
  Widget getLoginSide(){
    return  Expanded(
      child: Container(


        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Padding(
            //   padding:  EdgeInsets.symmetric(horizontal:0),
            //  // child: TopHeader(),
            // ),

            Column(
              children: [

                //SizedBox(height: 50,),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 150),
                    child: CustomTextFeild(text: "EMAIL", controller: emailController)),
                SizedBox(height: 20,),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 150),
                    child: CustomTextFeild(text: "PASSWORD", controller: passwordController)),
                Row(
                  children: [
                    SizedBox(width: 170,),
                    Expanded(child: Container(child:CommonText(text: 'Forget your password?',color: AppColors.greyColor,fontSize: 15)) ),
                  ],
                ),
                SizedBox(height: 40,),
                CustomButtom(text: 'LOGIN' ,ontap: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  HomePage()),
                      );
                      },)

              ],
            ),
            //Container()

          ],
        ),
      ),
    );
  }
  Widget getImageSide(){
    return  Expanded(
        child:Container(
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

             CommonBoldText(text: 'INTEGRITY',fontSize: 100,color: Colors.white,fontWeight: FontWeight.w500,),
              CommonBoldText(text: 'ANALYZER',fontSize: 100,color: Colors.white,fontWeight: FontWeight.w500,)
            ],
          ),
        ));
  }


  Widget getTopHeader(){
    return Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
          width: 600,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.4),
                  spreadRadius: 4,
                  blurRadius: 5
              ),
            ],
            color: AppColors.backGroundColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(100),bottomRight: Radius.circular(100),),
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/common/logo png f.png",height: 60,),
            ],
          )
        ),
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


}
