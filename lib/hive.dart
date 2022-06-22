
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class MyHive{

  Future<void> initMethodHive()async {
    if(!kIsWeb && [Platform.isWindows, Platform.isLinux, Platform.isMacOS, Platform.isAndroid, Platform.isIOS].contains(true)){
      String tempPath = "";
      try {
        Directory tempDir = await getTemporaryDirectory();
        tempPath = tempDir.path;
        // setState((){});
        print('path:${tempPath}');
      }
      catch(e) {}

      if(tempPath.isNotEmpty) {
        Hive.init(tempPath);
      }
    }
  }

  Future<Box<Map>> initHive()async{
    Box<Map> porelabbox;
    porelabbox=await Hive.openBox<Map>("porelabbox");
    print('gotbox :${porelabbox}');
    print('length:${porelabbox.toMap()}');

    return porelabbox;
  }
}