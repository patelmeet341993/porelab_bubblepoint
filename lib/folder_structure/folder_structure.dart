
import 'package:firedart/firedart.dart'as fireDart;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/utils/hive_manager.dart';
import 'package:porelab_bubblepoint/utils/my_print.dart';

class FolderStructure extends StatefulWidget {
  const FolderStructure({Key? key}) : super(key: key);

  @override
  State<FolderStructure> createState() => _FolderStructureState();
}

class _FolderStructureState extends State<FolderStructure> {

  List<Map<String, dynamic>> testList = [];


  Future<void> getData()async{
    fireDart.Page<fireDart.Document> values = await fireDart.Firestore.instance.collection("users").document("N0048").collection("files").document("bubblepoint").collection("files").get();
    print("values: ${values.length}");
    for (var element in values) {
      MyPrint.logOnConsole("value: ${element.id}");
      print(element.id);
    }

    // try {
    //  await HiveManager().set("values", (values.map((element) => element.id)));
    // } catch (e,s){
    //   print("Hive set value ${e} stack trace: $s");
    // }
    //
    //
    // try {
    //    testList = await HiveManager().get("values");
    //    if (kDebugMode) {
    //      // print("values: ${testList.length}");
    //    }
    //
    // } catch (e,s){
    //   if (kDebugMode) {
    //     print("Hive get value $e stack trace: $s");
    //   }
    // }
    // print(testList);
    setState((){});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          itemCount: testList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing: 10,mainAxisSpacing: 10),
          itemBuilder: (BuildContext context, int index ){
            return Container(
              height: 50,
              width: 50,
              color: Colors.green,
              child: Text("${testList.first}"),
            );
          }),
    );
  }
}
