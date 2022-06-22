import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_boldtext.dart';
import 'package:porelab_bubblepoint/views/commons/custom_smallbutton.dart';

import '../../config/common_text.dart';

class TopHeader extends StatelessWidget {
  IconData? icon;
  bool show ;
  String text;
   Function()? ontap;
   TopHeader({ this.icon , this.show=false ,required this.text,this.ontap});
   @override
  Widget build(BuildContext context) {
    return   Container(
      padding: EdgeInsets.symmetric(vertical: 30),
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
      child: Row(

        children: [
          SizedBox(width: 20,),
         show == false ? Container(

             child: SizedBox(width: 85,height: 15,)):CustomSmallButton(icon: icon! ,ontap: ontap,),
          SizedBox(width: 120,),
          CommonBoldText(text: text,color: Colors.white,fontSize: 40,fontWeight:FontWeight.w500,)
        ],
      ),
    ) ;
  }
}

