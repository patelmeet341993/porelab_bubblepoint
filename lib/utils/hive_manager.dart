import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveManager {
  static HiveManager? _instance;

  // File path to a file in the current directory
  String dbName = 'mydatabase';
  String boxName = 'mybox';

  Box? hivebox;

  factory HiveManager() {
    _instance ??= HiveManager._();
    return _instance!;
  }

  HiveManager._();

  Future<Box> get box async {
    print("path : $hivebox");

    if(hivebox == null) {
      final appDocumentDir = await getTemporaryDirectory();
      final dbPath = "${appDocumentDir.path}/$dbName";
      print("path : $dbPath");
      Hive.init(dbPath);
      hivebox = await Hive.openBox(boxName);
    }
    return hivebox!;
  }

  Future<dynamic> get(String key, {dynamic defaultValue}) async {
    Box db = await box;

    return db.get(key, defaultValue: defaultValue);
  }

  Future<dynamic> set(String key, dynamic value) async {
    Box db = await box;

    await db.put(key, value);
  }

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