import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../hive.dart';

class HiveController {
  static HiveController? _instance;

  factory HiveController() {
    _instance ??= HiveController._();
    return _instance!;
  }

  HiveController._();

  Future<Box<Map>> initialHive()async{
    Box<Map> firstBox;
    firstBox = await MyHive().initHive();
    return firstBox;

  }
}