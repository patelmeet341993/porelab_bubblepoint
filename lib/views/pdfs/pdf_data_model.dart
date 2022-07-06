import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class PdfDataModel{

  String coverPageImage = "" ;
  String sampleImage = "" ;
  Uint8List? graphImage =  Uint8List.fromList([]);
  String notes = "";
  String companyName;
  bool isGraph = true;
  bool isCoverPage = true;
  bool isRawData = true;

  PdfDataModel({
    this.graphImage,
    this.coverPageImage = "",
    required this.companyName,
    this.sampleImage = "",
    this.isCoverPage=true,
    this.isGraph=true,
    this.isRawData=true,
    this.notes=""
  });


}