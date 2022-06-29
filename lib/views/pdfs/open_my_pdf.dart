import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:porelab_bubblepoint/utils/my_print.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenMyPdf{

  static Future<File?> saveDocument({required Document pdf,required String name}) async {
    try {
      final Uint8List bytes = await pdf.save();
      final Directory? dir= await getApplicationDocumentsDirectory();
      if(dir != null) {
        final file=File("${dir.path}/$name.pdf");
        if(!file.existsSync()) file.createSync();
        await file.writeAsBytes(bytes);
        return file;
      }
    }
    catch(e) {
      print("Error in OpenMyPdf.saveDocument():${e}");
    }
  }

  static Future openFile(File file) async {
    final url=file.path;
    print("open file");
    await openUrl(url);
  }

  static Future openUrl(final url) async{
    MyPrint.printOnConsole("THis is the : $url");
    final Uri uri = Uri.file(url);
    MyPrint.printOnConsole("THis is the 2 : $uri");

    if (await File(uri.toFilePath()).exists()) {
      if (!await launchUrl(uri)) {
        throw 'Could not launch $uri';
      }
    }
    //await launchUrl(uri);
  }


}