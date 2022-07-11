import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/controller/provider/test_setup_provider.dart';
import 'package:porelab_bubblepoint/views/login_page/screens/home_page.dart';
import 'package:porelab_bubblepoint/views/test_setup/screens/grap_file.dart';
import 'package:provider/provider.dart';

import '../../../modals/test_setup_modal.dart';
import '../../commons/common_textfeildwith_gradient.dart';
import '../../commons/custom_button.dart';
class DailogBox extends StatefulWidget {
   TestSetupModal testSetupModal;
   String ?sampleId;

DailogBox({required this.testSetupModal,this.sampleId});


  @override
  State<DailogBox> createState() => _DailogBoxState();
}

class _DailogBoxState extends State<DailogBox> {

  TestSetupProvider? testSetupProvider;
  Box<Map>? firstBox;
  TextEditingController saveFileController=TextEditingController();
  final dialogKey = GlobalKey<FormState>();
  @override
  void initState(){
    saveFileController.text=widget.sampleId!;
  }
  @override
  Widget build(BuildContext context) {

    TestSetupProvider testSetupProvider=Provider.of<TestSetupProvider>(context);
    if(firstBox!=null){
      testSetupProvider.firstBox=firstBox;
    }
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GraphPage()),
                      );
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
                        Provider.of<TestSetupProvider>(context,listen: false).addlist(firstBox:testSetupProvider.firstBox!,testSetupModal: widget.testSetupModal,key: saveFileController.text.trim());
                        testSetupProvider.notifyListeners();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GraphPage()),
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
