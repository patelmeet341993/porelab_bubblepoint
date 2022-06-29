
import 'package:firedart/firedart.dart'as fireDart;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:porelab_bubblepoint/utils/hive_manager.dart';
import 'package:porelab_bubblepoint/utils/my_print.dart';

class FolderStructure extends StatefulWidget {
  const FolderStructure({Key? key}) : super(key: key);

  @override
  State<FolderStructure> createState() => _FolderStructureState();
}

class _FolderStructureState extends State<FolderStructure> {

  Map<String, dynamic> testList = {};
  Map<String, dynamic> subList = {};
  String selectedKey = "";


  Future<void> getData()async{
    fireDart.Page<fireDart.Document> values = await fireDart.Firestore.instance.collection("users").document("N0048").collection("files").document("bubblepoint").collection("files").get();
    print("values: ${values.length}");
    Map<String,dynamic> dataValue = {};
    for (var element in values) {
      dataValue.addAll({element.id:element.map});
    }
    if(dataValue.length == values.length){
    try {
     await HiveManager().set("values", dataValue);
    } catch (e,s){
      print("Hive set value ${e} stack trace: $s");
    }
    try {
        testList = await HiveManager().get("values");
      } catch (e,s){
        if (kDebugMode) {
          print("Hive get value $e stack trace: $s");
        }
     }
    }
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
      body: mainBody()
    );
  }

  Widget mainBody(){
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: SingleChildScrollView(
            child: mainFolderList()
          ),
        ),
        subListView(),
      ],
    );
  }

  Widget mainFolderList(){
    return Container(
        child:Wrap(
        children: testList.entries.map((e) {
        return InkWell(
          onTap: (){
            selectedKey = e.key;
            subList.clear();
            subList.addAll(e.value);
            setState((){});
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: 150,
                  color: Colors.green,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      ListTile(
                        title: Icon(selectedKey == e.key ? FontAwesomeIcons.solidFolderOpen : FontAwesomeIcons.solidFolder,size: 50,),
                      ),
                      const SizedBox(height: 3,),
                      Text(e.key)

                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
      )
    );
  }

  Widget subListView(){
    if(subList.isEmpty) {
      return const SizedBox();
    }
    return Expanded(
      child: ColoredBox(
        color: Colors.white,
        child: Column(children: subList.entries.map((e){
        return ListTile(
          onTap: (){
            print("value : ${e.value["flow"].runtimeType}");
          },
          title: Text(e.key),
        );
        }).toList(),),
      ));
  }
}
