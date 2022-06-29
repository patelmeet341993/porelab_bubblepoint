import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/views/commons/common_textfeild.dart';
import 'package:porelab_bubblepoint/views/commons/custom_button.dart';
import 'package:porelab_bubblepoint/views/commons/topheader.dart';

import '../../config/app_colors.dart';
import '../../config/common_boldtext.dart';

class PdfGenerateDialog extends StatefulWidget {
  const PdfGenerateDialog({Key? key}) : super(key: key);

  @override
  _PdfGenerateDialogState createState() => _PdfGenerateDialogState();
}

class _PdfGenerateDialogState extends State<PdfGenerateDialog> {

  TextEditingController companyNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width*0.50,
        decoration: BoxDecoration(
          color: AppColors.backGroundColor
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getDetailHeader(),

                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Icon(Icons.close,color: AppColors.whiteColor),
                  ),
                ),

              ],
            ),
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  getCompanyName(),
                  SizedBox(height: 20,),
                  getSampleImage(),
                  SizedBox(height: 20,),
                  getCompanyName(isNote: true),
                  SizedBox(height: 20,),
                  getGraphCheckBox(),
                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getCheckBox(),
                      SizedBox(width: 0,),
                      getCheckBox(),
                      SizedBox(width: 10,),
                      CustomButtom(text: "Browse Cover",)
                    ],
                  ),
                  SizedBox(height: 35,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtom(text: "Save to Pdf",),
                      SizedBox(width: 20,),
                      CustomButtom(text: "Save to Excel",),
                    ],
                  ),
                  SizedBox(height: 20,),



                ],
              ),
            )





          ],
        ),
      ),
    );
  }

  Widget getCompanyName({bool isNote = false}){
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: isNote?CrossAxisAlignment.start:CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 1,
            child: CommonBoldText(text: isNote ? "Notes":"Company Name",)),
        SizedBox(width: 25,),
        Expanded(
          flex: 3,
          child: Container(
              width: 300,
              child: CustomTextFeild(
                  text: isNote ? "Enter Notes":"Enter Company Name",
                  controller: companyNameController,
                borderRadius: 10,
                maxLines:isNote ? 3 : 1,
                //maxLines:1,
                minLines:isNote ? 3 : 1,
                height: null,
                verticalPadding: isNote ? 15 : 0,
                horizontalPadding: 20,

                //minLines:1,
              )),
        ),



      ],
    );
  }

  Widget getSampleImage(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: CommonBoldText(text: "Sample Image",)),
        SizedBox(width: 25,),
        Expanded(
          flex: 3,
            child: CustomButtom(text: "Browse",)
        )
      ],
    );

  }

  Widget getGraphCheckBox(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: CommonBoldText(text: "Graph",)),
        SizedBox(width: 25,),
        Expanded(
            flex: 3,
            child: getCheckBox()
        )
      ],
    );
  }

  Widget getCheckBox(){
    return Row(
      children: [
        Checkbox(
            value: true, 
            onChanged: (val){},
        ),
        SizedBox(width: 10,),
        CommonText(text: "Flow vs Pressure")
      ],
    );
  }


  Widget getDetailHeader(){
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
         // SizedBox(width: 20,),
          CommonBoldText(text: "Report Option",color: Colors.white,fontSize: 15,fontWeight:FontWeight.w500,),
        ],
      ),
    ) ;
  }

}
