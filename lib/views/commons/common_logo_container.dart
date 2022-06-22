import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

import '../../config/app_colors.dart';
class CommonLogoContainer extends StatelessWidget {

  String url;
   CommonLogoContainer({required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(100),
      child: Container(

        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(

            boxShadow: [
              BoxShadow(
                  color: AppColors.whiteColor,
                  blurRadius: 1.0,
                  spreadRadius:0.3
              ),
            ],
            border: Border.all(color: AppColors.blackColor),
            gradient: LinearGradient(
                stops: [0.03,.4],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.whiteColor,
                  AppColors.blackColor
                ]),
            //borderRadius: BorderRadius.circular(100)
          shape: BoxShape.circle
        ),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors().buttonColor,width: 2.2)
          ),
          child: Container(

              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      stops: [0.03,.4],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.whiteColor, AppColors.blackColor]),
              ),
              child: Image.asset(url,height: 60,color: Colors.lightBlue,)
          ),
        ),
      ),
    );
  }
}

/*
child: Icon(icon,color: AppColors().buttonColor,size: 15,),*/
