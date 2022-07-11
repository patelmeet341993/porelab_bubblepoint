
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
        return InkWell(
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
                        title: Icon(selectedKey == e.key ? FontAwesomeIcons.solidFolderOpen: FontAwesomeIcons.solidFolder,size: 50,color: selectedKey==e.key ? AppColors.lightBlueColor:AppColors.whiteColor.withOpacity(0.9)),
                      ),
                      const SizedBox(height: 3,),
                      CommonText(text: e.key,fontWeight: FontWeight.w500,color:Colors.white)

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height:170),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CommonBoldText(text: selectedKey,fontWeight: FontWeight.w500,color:Colors.white,)),
          Divider(color: AppColors.lightBlueColor,indent: 20,endIndent: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(children:
            [
             Expanded(child: CommonBoldText(text: 'Name',fontWeight: FontWeight.w500,color:Colors.white,)),
             Expanded(child: CommonBoldText(text: 'Date',color:Colors.white,fontWeight: FontWeight.w500))
            ],
            ),
          ),
          Divider(color: AppColors.lightBlueColor,indent: 20,endIndent: 20,),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: subList.entries.map((e){
                  return ListTile(
                    onTap: (){
                      FolderStructureProvider fsp = Provider.of<FolderStructureProvider>(context,listen: false);
                      Map<String,BubblePointModel> bubblePointMap =  {};
                      bubblePointMap[e.key] = BubblePointModel.fromJson(e.value);
                      fsp.bubblePointModelList.add(bubblePointMap);
                      print("length : ${fsp.bubblePointModelList.length}");
                    },
                    title: CommonText(text: e.key,)
                  );
                  }).toList(),),
                ),
                Expanded(
                  child: Container(
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(),
                  ),
                )
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
                  setState((){
                  });
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
        child: Center(child:CommonText(text: text,color:select==selected ? Colors.white :AppColors.whiteColor,) ),

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
