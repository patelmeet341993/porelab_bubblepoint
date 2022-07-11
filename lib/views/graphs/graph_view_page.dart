import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/utils/my_print.dart';
import 'package:porelab_bubblepoint/views/commons/modal_progress_hud.dart';
import 'package:porelab_bubblepoint/views/graphs/pdf_generate_dialog.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../modals/bubblePointModel.dart';
import '../pdfs/create_sample_pdf.dart';
import '../pdfs/open_my_pdf.dart';

class GraphViewPage extends StatefulWidget {
  List<BubblePointModel> bubblePointModelList;
  GraphViewPage({required this.bubblePointModelList});

  @override
  _GraphViewPageState createState() => _GraphViewPageState();
}

class _GraphViewPageState extends State<GraphViewPage> {

  Future? getFutureData;
  bool pageMounted = false,isLoading = false;
  List<LineChartBarData> chartBarDataList = [];
  ScreenshotController screenshotController = ScreenshotController();
  bool isDarkGraph=false;
  int colorIndex=0;
  List<List<Color>> graphColorList = [
    [Color(0xffDBBA4F)],
    [Color(0xff3F76B5)],
    [Color(0xffD67479)],
    [Color(0xff12B59F)],
    [Color(0xffF5903D)],
    [Color(0xffBC4644)],
    [Color(0xffAD4F73)],
    [Color(0xff40A7C1)],
    [Color(0xff95B64F)],
    [Color(0xff613769)],
    [Color(0xff234882)],
    [Color(0xffA1846A)],
  ];

  Future<void> getFlSpots() async {

    widget.bubblePointModelList.forEach((element) {
      List<FlSpot> flSpotList = [];
      for(int i=0;i<element.ans.length;i++){
        flSpotList.add(FlSpot(element.t[i],element.ans[i]));
      }
      chartBarDataList.add(
            LineChartBarData(
            spots: flSpotList,
            colors:graphColorList[colorIndex]
            )
        );
        colorIndex++;
      });

    MyPrint.printOnConsole("ab Length of data : ${widget.bubblePointModelList.length}");
    MyPrint.printOnConsole("ab Length of graphSpot : ${chartBarDataList.length}");

  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       pageMounted = true;
    });
    getFutureData = getFlSpots();
  }

  @override
  Widget build(BuildContext context) {
    pageMounted=false;
    return FutureBuilder(
      future: getFutureData,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Results",style: TextStyle(color: Colors.white)),
              automaticallyImplyLeading: true,
              elevation: 2,

              leading: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,color: Colors.white)),
              backgroundColor: AppColors.backGroundColor,
              actions: [
                Tooltip(
                    message: "Generate PDF",
                    child: InkWell(
                        onTap: ()async{
                          MyPrint.printOnConsole("Page Mounted a above : $pageMounted");
                          setState(() {
                            isLoading=true;
                            isDarkGraph = true;
                          });
                          await Future.delayed(Duration(seconds: 2));

                          /*while(pageMounted){
                            await Future.delayed(Duration(milliseconds: 20));
                          }*/
                          Uint8List? graphImage = await screenshotController.capture();
                          showDialog(
                              context: context,
                              builder: (context){
                                return PdfGenerateDialog(bubblePointModel: widget.bubblePointModelList[0],graphImage: graphImage ?? Uint8List.fromList([]),);
                              }
                          );

                          setState(() {
                            isDarkGraph = false;
                            isLoading=false;

                          });
                          /*final graphImage=await screenshotController.capture();
                          final pdf = await CreateSamplePdf().generatePdf(text: "My Pdf",graphImage: graphImage!);
                          OpenMyPdf.openFile(pdf!);*/
                        },
                        child: Icon(Icons.description,color: Colors.white,size: 30))),
                SizedBox(width: 30,)

              ],
            ),
            body: ModalProgressHUD(
              inAsyncCall: isLoading,
              progressIndicator:Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.backGroundColor,child: Center(child: CircularProgressIndicator(color: AppColors.lightBlueColor))),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Screenshot(
                      controller: screenshotController,
                      child: Container(
                         margin: EdgeInsets.symmetric(horizontal: 10).copyWith(left: 10),
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Text("F/PT vs Time",style: TextStyle(color: isDarkGraph?Colors.black:Colors.white,fontWeight: FontWeight.bold,fontSize: 25)),
                            Expanded(child: Padding(
                              padding:  EdgeInsets.symmetric(vertical: 30.0,horizontal: 10  ),
                              child: getGraph(),
                            )),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                    child: VerticalDivider(color: Colors.grey,thickness: 1,),
                  ),
                  Expanded(
                      child: getGraphInfoBody()
                  )
                ],
              ),
            ),
          );
        }else{
          return CircularProgressIndicator();
        }
        },
    );
  }

  Widget getGraph(){
    return LineChart(
      LineChartData(
        borderData: FlBorderData(
          show: true,
          border: Border(
            left: BorderSide(color: isDarkGraph?Colors.black:Colors.white),
            right: BorderSide(color: isDarkGraph?Colors.black:Colors.white),
            bottom: BorderSide(color:isDarkGraph?Colors.black: Colors.white),
            top: BorderSide(color: isDarkGraph?Colors.black:Colors.white),
          )
        ),

        axisTitleData: FlAxisTitleData(
          leftTitle: AxisTitle(
            showTitle: true,
            titleText: "F/PT",
            textStyle: TextStyle(
              fontSize:isDarkGraph ?30: 20,
              color: isDarkGraph ? Colors.black : Colors.white
            )
          ),
          bottomTitle: AxisTitle(
            showTitle: true,
          titleText: "Time (seconds)",
              textStyle: TextStyle(
                  fontSize: isDarkGraph ?30:20,
                  color: isDarkGraph?Colors.black:Colors.white
              )
        )
        ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
            //textAlign: TextAlign.start,
            showTitles: true,
                textAlign: TextAlign.center,
                getTextStyles:(contex,val){
                  return TextStyle(
                      fontSize: 13,
                      color:isDarkGraph?Colors.black: Colors.white,
                      fontWeight: FontWeight.bold
                  );

                }


            ),
          leftTitles: SideTitles(
            reservedSize: 30,
            textAlign: TextAlign.center,
            getTextStyles:(contex,val){
              return TextStyle(
                fontSize: 13,
                  color: isDarkGraph?Colors.black:Colors.white,
                  fontWeight: FontWeight.bold
              );

            } ,
            showTitles: true,
          ),
          rightTitles: SideTitles(
            showTitles: false,
          ),
          topTitles: SideTitles(
            showTitles: false,
          ),
        ),
        /*lineBarsData: [
          LineChartBarData(
            spots: flSpotList,
            colors: [Colors.green]
          ),
          LineChartBarData(
              spots: [
                FlSpot(20, 1000),
                FlSpot(40, 2000),
                FlSpot(50, 5000),
                FlSpot(60, 6000),
                FlSpot(70, 7000),
                FlSpot(80, 800),
                FlSpot(90, 900),
              ],
              colors: [Colors.blueAccent]
          ),
          LineChartBarData(
              spots: [
                FlSpot(15, 150),
                FlSpot(25, 2500),
                FlSpot(5, 100),
                FlSpot(35, 3500),
                FlSpot(40, 4000),
                FlSpot(55, 550),
                FlSpot(65, 4500),
              ],
              colors: [Colors.red]
          ),
        ]*/
        lineBarsData: chartBarDataList
      )

    );
  }

  Widget getGraphInfoBody(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                getBlueDivider(),
                Row(
                  children: [
                    Expanded(flex: 3,child: CommonText(text: "Sample Name",color: Colors.white,)),
                    Expanded(child: CommonText(text: "Bubble Pressure",color: Colors.white,)),
                    Expanded(child: CommonText(text: "Bubble Diameter",color: Colors.white,)),
                  ],
                ),
                getBlueDivider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                      itemBuilder: (context,index){
                        return getFilesList(bdiameter: "newFile",bpressure: "2.45",fileName: "178.25");
                    }
                  ),
                )




              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                getBlueDivider(),
                Row(
                  children: [
                   Expanded(flex: 2,child: CommonText(text: "Average Bubble Diameter",color: Colors.white,)),
                   CommonText(text: "178.25 (mn)",color: Colors.white,),
                  ],
                ),
                getBlueDivider(),
                SizedBox(height: 20,),
                getCircularDiameterView(),

                


              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getBlueDivider(){
    return Divider(color: Colors.blueAccent,thickness: 1,);
  }

  Widget getFilesList({String fileName="",String bpressure="",String bdiameter="",}){
    return Row(
      children: [
        Expanded(flex: 3,child: CommonText(text: fileName,color: Colors.white,)),
        Expanded(child: CommonText(text: bpressure,color: Colors.white,)),
        Expanded(child: CommonText(text: bdiameter,color: Colors.white,)),
      ],
    );
  }

  Widget getCircularDiameterView(){
    return Column(
      children: [
        CommonText(text: "Bubble Point Diameter",color: Colors.white,),
        CommonText(text: "( Macro Pore )",color: Colors.white,),
        SizedBox(height: 15,),
        Stack(
          children: [
            Container(
              height: 120,
              width: 120,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                gradient:LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black12,
                    Colors.black12,
                    Colors.black54,
                    Colors.black54,
                    Colors.black54,
                    Colors.black54,
                    Colors.black54,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ]
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)
                ),
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    infoProperties:InfoProperties(
                      modifier: (val){
                        return "";
                      }

                    ),
                    customWidths: CustomSliderWidths(
                      shadowWidth: 0,
                      trackWidth: 22,
                      handlerSize: 0,
                      progressBarWidth: 22
                    ),
                    customColors: CustomSliderColors(
                        trackColor: Colors.grey,
                      progressBarColor: Colors.grey.shade800
                    ),
                  ),
                  initialValue: 30,
                  onChange: (double value){
                    print(value);
                  },

                )


              ),
            ),
            Positioned(
              left: 0,
                right: 0,
                top: 35,
                child: Column(
                  children: [
                    Text("BP Diameter",style: TextStyle(fontSize: 7,fontWeight: FontWeight.bold),),
                    Text("178.8",style: TextStyle(fontSize: 23),),
                    Text("mm",style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),),
                  ],
                )
            ),
          ],
        ),


      ],
    );
  }





}


// colors.add("#DBBA4F");
// colors.add("#3F76B5");
// colors.add("#D67479");
// colors.add("#12B59F");
// colors.add("#F5903D");
// colors.add("#BC4644");
// colors.add("#AD4F73");
// colors.add("#40A7C1");
// colors.add("#95B64F");
//
//
// colors.add("#613769");
// colors.add("#234882");
// colors.add("#A1846A");
