import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/views/login_page/screens/home_page.dart';

import '../../commons/common_textfeildwith_gradient.dart';
import '../../commons/custom_button.dart';
class DailogBox extends StatefulWidget {
  const DailogBox({Key? key}) : super(key: key);

  @override
  State<DailogBox> createState() => _DailogBoxState();
}

class _DailogBoxState extends State<DailogBox> {
  TextEditingController saveFileController=TextEditingController();
  final dialogKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
          key: dialogKey,
          child: Dialog(
            backgroundColor: Colors.transparent,
      child: Container(
          height: 300,
          width: 600,
          // padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:AppColors.backGroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(text: 'GIVE NAME TO SAVE YOUR FILE',fontSize: 20,),
              SizedBox(height: 30,),
              CommonTextfeildwithGradient(controller: saveFileController,width: 400,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30,),

              CommonText(text: 'DO YOU WANT TO SAVE THE FILE ?',fontSize: 20,),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtom(text: 'NO',
                    ontap: (){
                    Navigator.pop(context);
                    },),
                  SizedBox(width: 40,),
                  CustomButtom(text: 'YES',
                    ontap: (){
                      if (!dialogKey.currentState!.validate()) {
                        dialogKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('error')),
                        );
                      }
                      else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                      },),


                ],
              ),
            ],
          ),
      ),
    ),
        )
    );
  }
}
