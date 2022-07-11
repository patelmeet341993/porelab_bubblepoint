
import 'package:firedart/firedart.dart'as fireDart;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_boldtext.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/controller/provider/folder_structure_provider.dart';
import 'package:porelab_bubblepoint/modals/bubblePointModel.dart';
import 'package:porelab_bubblepoint/utils/hive_manager.dart';
import 'package:porelab_bubblepoint/views/commons/topheader.dart';
import 'package:provider/provider.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

import '../graphs/graph_view_page.dart';

class FolderStructure extends StatefulWidget {
  const FolderStructure({Key? key}) : super(key: key);

  @override
  State<FolderStructure> createState() => _FolderStructureState();
}

class _FolderStructureState extends State<FolderStructure> {
  int select=0;
  bool sync=false;
  int buttonselect=0;
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
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeader(text: 'My Cloud',show: true,icon:Icons.arrow_back_ios_outlined,ontap: (){
                Navigator.pop(context);
              },),
              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          showSearch(context: context,
                            delegate: CustomSearchDelegate(),);
                          },
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.blackColor,
                                AppColors.backGroundColor
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.whiteColor,
                                offset: Offset(-3, -0),
                                blurRadius: 1.0,
                                spreadRadius:1,
                              ),
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(4, 0),
                                blurRadius: 1.0,
                                spreadRadius:1,
                              ),
                            ],

                          ),
                          child: TextFormField(
                            enabled: false,
                            //textAlign: textAlign,
                            style: TextStyle(color: AppColors.whiteColor),
                            cursorColor: AppColors.whiteColor,
                            decoration: InputDecoration(
                              hintText:'Search Sample',
                              hintStyle: TextStyle(fontSize: 16,color: AppColors.whiteColor),
                              counterStyle: TextStyle(color: AppColors.whiteColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius. circular(100.0),
                              ),
                              fillColor:Colors.transparent,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),

                              focusedErrorBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
                              errorBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
                              enabledBorder: OutlineInputBorder( borderRadius: BorderRadius. circular(100.0),borderSide: BorderSide(color: Colors.transparent)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(width: 8,),
                          Expanded(child: getTab(text: 'Weekly',onTap: (){
                            setState((){
                              select=0;
                            });

                          },selected: 0
                          )),
                          SizedBox(width: 8,),
                          Expanded(child: getTab(text: 'Daily',
                              onTap: (){

                                select=1;
                                setState((){

                                });
                              },selected: 1)),
                          SizedBox(width: 8,),
                          Expanded(child: getTab(text: 'All',onTap: (){

                            select=2;
                            setState((){

                            });
                          },selected: 2)),
                          SizedBox(width: 8,),
                        ],
                      ),
                    ),
                    SizedBox(width: 100,),
                    CupertinoSwitch(
                      activeColor: AppColors.whiteColor,
                      trackColor: AppColors.whiteColor,
                      thumbColor: AppColors.lightBlueColor,
                      value:sync ,
                     onChanged: (bool ? value){
                              {
                              setState(() {
                              sync= value!;
                              });
                              }},
                    ),
                    SizedBox(width: 5),
                    CommonText(text: 'Sync'),
                    SizedBox(width: 15),
                    InkWell(
                        onTap: (){},
                        child: Icon(Icons.download,color: AppColors.lightBlueColor,size: 30,))
                  ],
                ),
              ),
              SizedBox(height: 5),
              Divider(color: AppColors.lightBlueColor,endIndent: 60, indent: 20),
              SingleChildScrollView(child: mainFolderList()),
            ],
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
        return Stack(
          children: [
            InkWell(
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
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

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          ListTile(
                            title: Icon(selectedKey == e.key ? FontAwesomeIcons.solidFolderOpen: FontAwesomeIcons.solidFolder,size: 50,color: selectedKey==e.key ? AppColors.lightBlueColor:AppColors.greyColor),
                          ),
                          const SizedBox(height: 3,),
                          CommonText(text: e.key,)

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: (){
                if(selectedKey == e.key) {
                  if (isSelectAll) {
                    isSelectAll = false;
                    subList.entries.forEach((element) {
                      checkedItem.remove(element.key);
                      selectedBubblePointModel.remove(element.key);
                    });
                    selectedItem.remove(selectedKey);
                  } else {
                    isSelectAll = true;
                    subList.entries.forEach((element) {
                      if (!checkedItem.contains(element.key)) {
                        checkedItem.add(element.key);
                        selectedBubblePointModel.addAll({element.key : BubblePointModel.fromJson(element.value)});
                      }
                    });
                    selectedItem[selectedKey] = checkedItem;
                  }
                  print(selectedItem);
                  print("selected bubblepoint length: ${selectedBubblePointModel.length}");

                  setState(() {});
                }
              },
              child: !selectedItem.containsKey(e.key)  ? Icon( FontAwesomeIcons.circle,color: AppColors.lightBlueColor,) : Icon( FontAwesomeIcons.solidCircleCheck,color: AppColors.lightBlueColor),
            ),
          ],
        );
      }).toList(),
      )
    );
  }

  List<String> checkedItem = [];
  Map<String, BubblePointModel> selectedBubblePointModel = {};
  Map<String,dynamic> selectedItem = {};
  bool isSelectAll = false;

  Widget subListView(){
    if(subList.isEmpty) {
      return const SizedBox();
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height:170),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CommonBoldText(text: selectedKey,fontWeight: FontWeight.w500,color:AppColors.whiteColor,)),
          Divider(color: AppColors.lightBlueColor,indent: 20,endIndent: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(children:
            [
             Expanded(child: CommonBoldText(text: 'Name',fontWeight: FontWeight.w500,color:AppColors.whiteColor,)),
             Expanded(child: CommonBoldText(text: 'Date',color:AppColors.whiteColor,fontWeight: FontWeight.w500))
            ],
            ),
          ),
          Divider(color: AppColors.lightBlueColor,indent: 20,endIndent: 20,),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                     // ListTile(
                     //   leading: Container(
                     //     child: !isSelectAll ? Icon( FontAwesomeIcons.circle,color: AppColors.lightBlueColor,) : Icon( FontAwesomeIcons.solidCircleCheck,color: AppColors.lightBlueColor),
                     //
                     //   ),
                     //     title: CommonText(text: "Select All",),
                     //   onTap: (){
                     //
                     //     print("select all : ${subList.keys.contains(selectedItem[selectedKey])}");
                     //
                     //
                     //     if(isSelectAll){
                     //       isSelectAll = false;
                     //       subList.entries.forEach((element) {
                     //         checkedItem.remove(element.key);
                     //       });
                     //       selectedItem.remove(selectedKey);
                     //     } else {
                     //       isSelectAll = true;
                     //       subList.entries.forEach((element) {
                     //         if(!checkedItem.contains(element.key)){
                     //           checkedItem.add(element.key);
                     //         }
                     //       });
                     //       selectedItem[selectedKey] = checkedItem;
                     //     }
                     //     print(selectedItem);
                     //     setState((){});
                     //   },
                     // ),
                      Column(
                        children: subList.entries.map((e){
                      return ListTile(
                        leading: Container(
                          child: !checkedItem.contains(e.key) ? Icon( FontAwesomeIcons.circle,color: AppColors.lightBlueColor,) : Icon( FontAwesomeIcons.solidCircleCheck,color: AppColors.lightBlueColor),
                        ),
                        onTap: (){
                          if(checkedItem.contains(e.key)){
                            checkedItem.remove(e.key);
                            selectedBubblePointModel.remove(e.key);
                            if(checkedItem.isEmpty){
                              selectedItem.remove(selectedKey);
                              isSelectAll = false;
                            }
                          } else {
                            checkedItem.add(e.key);
                            selectedBubblePointModel.addAll({e.key:BubblePointModel.fromJson(e.value)});
                            selectedItem[selectedKey] = checkedItem;
                          }
                          print("selected bubblepoint length: ${selectedBubblePointModel}");

                          // print("values: ${checkedItem.toString()}");
                          setState((){});
                          // BubblePointModel bp = BubblePointModel.fromJson(e.value);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context){
                          //       return GraphViewPage(
                          //         bubblePointModel: bp,
                          //       );
                          //     }
                          //   ),
                          // );
                          // FolderStructureProvider fsp = Provider.of<FolderStructureProvider>(context,listen: false);
                          // Map<String,BubblePointModel> bubblePointMap =  {};
                          // bubblePointMap[e.key] = BubblePointModel.fromJson(e.value);
                          // fsp.bubblePointModelList.add(bubblePointMap);
                          // print("bp : ${bp.toJson()}");
                        },
                        title: CommonText(text: e.key,)
                      );
                      }).toList(),),
                    ],
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     color: Colors.green,
                //     width: MediaQuery.of(context).size.width,
                //     height: MediaQuery.of(context).size.height,
                //     child: Column(),
                //   ),
                // )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getButton(onTap: (){
                  setState((){

                  });
                  buttonselect=0;
                }, text: 'Delete',selected: 0),
                getButton(onTap: (){
                  buttonselect=1;
                  List<BubblePointModel> bubblePointList = [];
                  selectedBubblePointModel.values.forEach((element) {bubblePointList.add(element);});

                  if(bubblePointList.length >10){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(
                          'You Cannot Select More then 10 Files')),
                    );
                    return;
                  }

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return GraphViewPage(
                          bubblePointModelList:bubblePointList ,
                        );
                      }
                    ),
                  );
                  setState((){
                  });

                  /*List<BubblePointModel> bubblePointList = [BubblePointModel(
                      ans: [
                        578.5234966216216,3763.581428571427,-4506.393552631579,4969.262608695657,-5708.098500000003,7278.568085106381
                      ],
                      t: [
                        6.0,7.0,7.0,8.0,8.0,9.0
                      ]
                  ), BubblePointModel(
                    ans: [
                     200.5234966216216,2500.581428571427,-2506.393552631579,1515.262608695657,-2808.098500000003,-100.568085106381
                    ],
                    t: [
                     1.0,5.0,8.0,12.0,14.0,12.5
                    ]
                  ), BubblePointModel(
                    ans: [
                     458.5234966216216,3763.581428571427,-506.393552631579,2549.262608695657,-508.098500000003,278.568085106381
                    ],
                    t: [
                     10.0,15.0,17.0,18.0,18.5,19.0
                    ]
                  ),];
                 */
                }, text: 'Generate',selected: 1)
              ],
            ),
          ),
          SizedBox(height: 10,)
        ],
      ));
  }

  Widget getTab({required String text, required Function()  onTap,int selected=0}){
    return InkWell(
        onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.whiteColor,
              offset: Offset(-1, -1),
              blurRadius: 5.0,
              spreadRadius:2,
            ),
            BoxShadow(
              color: Colors.black,
              offset: Offset(5, 5),
              blurRadius: 5.0,
              spreadRadius:2,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color:  select==selected ? AppColors.greyColor :AppColors.blackColor,
        ),
        child: Center(child:CommonText(text: text,color:select==selected ? AppColors.blackColor :AppColors.whiteColor,) ),

      ),
        );
  }

  Widget getButton({required Function() onTap,required String text,int selected=0}){
    return TouchRippleEffect(
      borderRadius: BorderRadius.circular(30),
      rippleColor: AppColors.blackColor,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
           color: buttonselect==selected?AppColors.lightBlueColor:AppColors.greyColor
        ),
          child: CommonText(text: text,color: AppColors.whiteColor,fontSize: 18,)
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate{
  List<String> Seacrhterms=[
    'golf',
    'mini militia',
    'cross zero',
    'hide and seek',
    'pubg',
    'suduko',
    'car race',
    'coc',
    'nimo',
    'fruit ninja',
    'vector',
    'clash royal',
    'chess',
    'puzzle',
    'truck racing',
    'dr driving',
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return[
      IconButton(
        icon:Icon( Icons.clear),
        onPressed:(){
          query="";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchstring=[];
    for (var games  in  Seacrhterms) {
      if (games.toLowerCase().contains(query.toLowerCase())) {
        matchstring.add(games);
      };
    }
    return ListView.builder(
        itemCount: matchstring.length,
        itemBuilder: (context, index){
          var result=matchstring[index];
          return ListTile(
            title: Text(result),
          );
        }

    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchstring=[];
    for (var games  in  Seacrhterms) {
      if (games.toLowerCase().contains(query.toLowerCase())) {
        matchstring.add(games);
      };
    }
    return ListView.builder(
        itemCount: matchstring.length,
        itemBuilder: (context, index){
          var result=matchstring[index];
          return ListTile(
            title: Text(result),
          );
        }

    );
  }
}
