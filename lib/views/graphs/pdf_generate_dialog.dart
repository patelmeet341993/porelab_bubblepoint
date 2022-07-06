import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/utils/my_print.dart';
import 'package:porelab_bubblepoint/views/commons/common_textfeild.dart';
import 'package:porelab_bubblepoint/views/commons/custom_button.dart';
import 'package:porelab_bubblepoint/views/commons/topheader.dart';
import 'package:porelab_bubblepoint/views/pdfs/pdf_data_model.dart';
import '../../config/app_colors.dart';
import '../../config/common_boldtext.dart';
import 'package:file_picker/file_picker.dart';

import '../../modals/bubblePointModel.dart';
import '../pdfs/create_sample_pdf.dart';
import '../pdfs/open_my_pdf.dart';


class PdfGenerateDialog extends StatefulWidget {
  BubblePointModel bubblePointModel;
   Uint8List graphImage;

  PdfGenerateDialog({required this.bubblePointModel,required this.graphImage});

  @override
  _PdfGenerateDialogState createState() => _PdfGenerateDialogState();
}

class _PdfGenerateDialogState extends State<PdfGenerateDialog> {

  TextEditingController companyNameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PlatformFile? sampleFile;
  PlatformFile? coverFile;
  bool isGraph = true;
  bool isRawData = true,isCover = true;

  Future<void> pickImage() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image,allowedExtensions: ["jpeg","jpg","png"]);
    if (result == null) return;
    sampleFile = result.files.first;
    print('File Name: ${sampleFile?.name ?? ""}');
    print('File Size: ${sampleFile?.size ?? ""}');
    print('File Extension: ${sampleFile?.extension ?? ""}');
    print('File Path: ${sampleFile?.path ?? ""}');

  }

  Future<void> pickCoverImage() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image,allowedExtensions: ["jpeg","jpg","png"]);
    if (result == null) return;
    coverFile = result.files.first;
    print('File Name: ${coverFile?.name ?? ""}');
    print('File Size: ${coverFile?.size ?? ""}');
    print('File Extension: ${coverFile?.extension ?? ""}');
    print('File Path: ${coverFile?.path ?? ""}');

  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width*0.55,
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
                    getSampleImage(
                      file: sampleFile,
                      onTap: ()async{
                        await pickImage();
                        setState(() {});
                      }
                    ),
                    SizedBox(height: 20,),
                    getCompanyName(isNote: true),
                    SizedBox(height: 20,),
                    getGraphCheckBox(),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getCheckBox(
                          title: "Raw Data",
                          onChanged: (val){
                            setState(() {
                              isRawData=val ?? isRawData;
                            });

                          },
                          value: isRawData,

                        ),
                        SizedBox(width: 15,),
                        getCheckBox(
                          title: "Cover Page",
                          value: isCover,
                            onChanged: (val){
                              setState(() {
                                isCover=val ?? isCover;
                              });

                            }
                        ),
                        SizedBox(width: 10,),
                        CustomButtom(
                          text: "Browse Cover",
                          ontap: () async {
                            await pickCoverImage();
                            setState(() {
                            });},
                        ),
                        SizedBox(width: 10,),
                        coverFile != null ? Container(
                          height: 80,
                          width: 80,
                          child: Image.file(
                              File(coverFile?.path.toString() ?? "")
                          ),
                        ) : Container()
                      ],
                    ),
                    SizedBox(height: 35,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtom(
                          text: "Save to PDF",
                            ontap: () async {
                            if(_formKey.currentState!.validate()){
                              final pdf = await CreateSamplePdf().generatePdf(
                                pdfDataModel: PdfDataModel(
                                  companyName: companyNameController.text,
                                  notes: noteController.text,
                                  isGraph: isGraph,
                                  graphImage: widget.graphImage,
                                  isCoverPage: isCover,
                                  isRawData: isRawData,
                                  coverPageImage: coverFile?.path ?? "",
                                  sampleImage: sampleFile?.path ?? ""
                                ),
                                bubblePointModel: widget.bubblePointModel
                              );
                              OpenMyPdf.openFile(pdf!);
                            }
                          }
                         ),
                       /* SizedBox(width: 20,),
                        CustomButtom(text: "Save to Excel",),*/
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getCompanyName({bool isNote = false,}){
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
                  controller: isNote ? noteController : companyNameController,
                borderRadius: 10,
                maxLines:isNote ? 3 : 1,
                validator: (value){
                 if(!isNote){
                  if (value == null || value.isEmpty) {
                    return 'Please enter company name';
                  }
                  return null;
                 }
                 },
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

  Widget getSampleImage({Function()? onTap,PlatformFile? file}){
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
            child:
            Row(
              children: [
                CustomButtom(
                  text: "Browse",
                  ontap: onTap,
                ),
                SizedBox(width: 20,),
                file != null ? Container(
                  height: 80,
                  width: 80,
                  child: Image.file(
                      File(file.path.toString())
                  ),
                ) : Container()

              ],
            )
        ),

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
            child: getCheckBox(
              value: isGraph,
              onChanged: (val){
                 setState(() {
                   isGraph=val ?? isGraph;
                 });

              }


            )
        )
      ],
    );
  }

  Widget getCheckBox({Function(bool?)? onChanged,bool value=true,String title = "Flow vs Pressure"}){
    return Row(
      children: [
        Checkbox(
            value: value,
            onChanged: onChanged,
        ),
        SizedBox(width: 4,),
        CommonText(text: title)
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
