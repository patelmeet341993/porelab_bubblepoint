import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../modals/test_setup_modal.dart';

class TestSetupProvider extends ChangeNotifier{
  Box<Map>? firstBox;
  TestSetupModal? testSetupModal;
List<TestSetupModal>list=[];

void addlist({required Box<Map> firstBox,required TestSetupModal testSetupModal, required String key}){
  list.add(testSetupModal);
  // firstBox.add(testSetupModal.toMap());
  firstBox.put(key, testSetupModal.toMap());
  notifyListeners();
}

}