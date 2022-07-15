import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
class CustomButtom extends StatelessWidget {
 String text;
 Function()? ontap;
 double horizonal;
 double vertical;
 double fontSize;
CustomButtom({required this.text,this.ontap,this.horizonal=20,this.vertical=6,this.fontSize=18});
  @override
  Widget build(BuildContext context) {
    return TouchRippleEffect(
      borderRadius: BorderRadius.circular(30),
      rippleColor: AppColors.blackColor,
      onTap: ontap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: horizonal,vertical: vertical),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
               AppColors.darkBlueColor,
                AppColors.lightBlueColor
              ],
            )
        ),
        child: CommonText(text: text,color: AppColors.whiteColor,fontSize: fontSize,)

      ),
    );
  }
}
