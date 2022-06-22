import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
class CustomContainer extends StatelessWidget {
 double height;
 double width;
 IconData icon;
CustomContainer({
   required this.icon,this.height=160,this.width=350
});
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.whiteColor,
                offset: Offset(-1, -1),
                blurRadius: 5.0,
                spreadRadius:2,
              ),
              BoxShadow(
                color: Colors.black,
                offset: Offset(5, 5),
                blurRadius: 5.0,
                spreadRadius:2,
              ),
            ],
            borderRadius: BorderRadius.circular(100),
            color: AppColors.blackColor
        ),
        child: Icon(icon,color: AppColors.whiteColor,)
    );
  }
}
