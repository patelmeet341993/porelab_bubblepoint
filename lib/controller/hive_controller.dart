import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../hive.dart';
import '../utils/hive_manager.dart';

class HiveController {
  static HiveController? _instance;

  factory HiveController() {
    _instance ??= HiveController._();
    return _instance!;
  }

  HiveController._();

  Future<Box<Map>> initialHive()async{
    Box<Map> firstBox;
    firstBox = await HiveManager().initHive();
    return firstBox;

  }
}