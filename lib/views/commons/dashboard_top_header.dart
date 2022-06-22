import 'package:flutter/material.dart';

import '../../config/common_text.dart';
import 'custom_smallbutton.dart';
class DashboardTopHeader extends StatelessWidget {
  String text;
  IconData icons;
   void Function() ? ontap;
  DashboardTopHeader({ this.ontap,required this.text,required this.icons});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        //color: Colors.green,
        width: 550,
        height: 150,
        margin: EdgeInsets.only(bottom: 10 ),
        decoration: BoxDecoration(
            color: Color(0xFF1A1A1A),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.4),
                  spreadRadius: 4,
                  blurRadius: 5
              ),

            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 50,),
                  InkWell(
                      onTap: ontap,
                      child: CustomSmallButton(icon: icons)),
                  SizedBox(width: 40,),

                  CommonText(text: text,fontSize: 35,fontWeight: FontWeight.w600),

              ],
            )
          ],
        ),

      ),
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width,size.height );
    path.lineTo(size.width-130,0.0);
    path.close();


    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper){
    return true;
  }

}

