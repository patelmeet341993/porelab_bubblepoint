import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

import '../../config/app_colors.dart';
class CustomSmallButton extends StatelessWidget {
IconData icon;
Function() ? ontap;
CustomSmallButton({required this.icon,this.ontap});
  @override
  Widget build(BuildContext context) {
    return TouchRippleEffect(
      borderRadius: BorderRadius.circular(30),
      rippleColor: AppColors.blackColor,
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(3),
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
            borderRadius: BorderRadius.circular(100)
        ),
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppColors().buttonColor)
          ),
          child: Container(

            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    stops: [0.03,.4],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.whiteColor, AppColors.blackColor]),
                borderRadius: BorderRadius.circular(100)
            ),
            child: Icon(icon,color:AppColors().buttonColor,size: 15,),
          ),
        ),
      ),
    );
  }
}
