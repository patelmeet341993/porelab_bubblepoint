import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
class CustomButtom extends StatelessWidget {
 String text;
 void Function() ? ontap;
CustomButtom({required this.text,this.ontap});
  @override
  Widget build(BuildContext context) {
    return TouchRippleEffect(
      borderRadius: BorderRadius.circular(30),
      rippleColor: AppColors.blackColor,
      onTap: ontap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 6),
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
        child: CommonText(text: text,color: AppColors.whiteColor,fontSize: 18,)

      ),
    );
  }
}
