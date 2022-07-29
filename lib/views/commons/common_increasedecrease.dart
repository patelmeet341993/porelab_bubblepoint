import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/views/commons/common%20_textfeildwithoutsuffix.dart';
import 'package:porelab_bubblepoint/views/commons/custom_smallbutton.dart';

import '../../config/common_text.dart';
class CommonIncreaseDecrease extends StatefulWidget {
 String title;

  TextEditingController controller;
 CommonIncreaseDecrease({required this.title,required this.controller});
  @override
  State<CommonIncreaseDecrease> createState() => _CommonIncreaseDecreaseState();
}

class _CommonIncreaseDecreaseState extends State<CommonIncreaseDecrease> {
  @override

  void initState() {
    super.initState();
    //widget.controller.text = "0";
  }
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
              flex: 2,
              child: CommonText(text: widget.title,fontSize: 25,)),
          Expanded(
            flex: 3,
            child: Container(
             
              child: Row(
                children: [
                  CustomSmallButton(icon: Icons.add,ontap: (){
                    double currentvalue =double.parse(widget.controller.text);
                    setState((){
                      currentvalue++;
                      widget.controller.text=(currentvalue).toString();
                    });
                  },),
                   SizedBox(width: 10,),
                  Expanded(
                      child: CommonTextfeildwithoutsuffix(textAlign:TextAlign.center,text:'',controller: widget.controller,)),
                    SizedBox(width: 10,),
                  CustomSmallButton(icon: Icons.horizontal_rule_sharp,ontap: (){
                    double currentvalue =double.parse(widget.controller.text);
                    if(double.parse(widget.controller.text)<=0){
                      widget.controller.text==0;
                    }
                    else{
                      currentvalue--;
                      widget.controller.text=(currentvalue).toString();
                    }
                    setState((){

                    });
                  },)
                ],
              ),
            ),
          )
        ]
    );
  }
}
