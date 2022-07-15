import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../config/app_colors.dart';
import '../../../config/my_size.dart';


class AboveProgressIndicator extends StatelessWidget {
  int curentStep =0;

   AboveProgressIndicator({Key? key,this.curentStep=0}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal:5,).copyWith(top: 10),
          child: StepProgressIndicator(
            totalSteps: 100,
            currentStep: curentStep,
            size: 30,
            padding: 0,
            selectedColor: Colors.yellow,
            unselectedColor: AppColors.blackColor,
            roundedEdges: Radius.circular(10),
            selectedGradientColor: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.lightBlueColor, AppColors.whiteColor],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getPositionedCircle(43,0),
            getPositionedCircle(330,100),
          ],
        ),
        Align(
          alignment: Alignment.center,
            child: getPositionedCircle(190,60)
        ),

      ],
    );
  }

  Widget getPositionedCircle(double left,int circlePosition){
    return  Container(
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
      height: 50,
      width: 50,
      child:Container(
        margin: EdgeInsets.all(10),
        height: 40,width: 40,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color :  curentStep >= circlePosition?AppColors.lightBlueColor:Colors.transparent
        ),
      ),
    );
  }
}

