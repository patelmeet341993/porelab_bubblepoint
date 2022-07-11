import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/config/common_text.dart';
import 'package:porelab_bubblepoint/views/commons/topheader.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../commons/custom_smallbutton.dart';
class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {


  List<FlSpot> flSpotList = [
    // FlSpot(5, 10),
    // FlSpot(6, 11),
    // FlSpot(7, 12),
    // FlSpot(8, 13),
    // FlSpot(9, 14),
  ];
  List<FlSpot> flSpotListFlow = [
    // FlSpot(5, 10),
    // FlSpot(6, 11),
    // FlSpot(7, 12),
    // FlSpot(8, 13),
    // FlSpot(9, 14),
  ];
  List<FlSpot> flSpotListPressure = [
    // FlSpot(5, 10),
    // FlSpot(6, 11),
    // FlSpot(7, 12),
    // FlSpot(8, 13),
    // FlSpot(9, 14),
  ];
  bool isDarkGraph=false;
double x=1.0;
double y=1.0;
  void incrementnumber(){
      x++;
      y++;
      print("in increment");
     flSpotList.add(FlSpot( x,Random().nextDouble()*10));
      flSpotListPressure.add(FlSpot(x,y));
      flSpotListFlow.add(FlSpot( Random().nextDouble()*10,Random().nextDouble()*10));
  }

  late Timer timer;
  double dd=0.0;
  double ddd=0.0;
 double d(){
 print('d');
  return dd++;
}
 double dddd(){
   print('dd');
   return ddd =double.parse((Random().nextDouble()*100).toStringAsFixed(2));
}
 void  myfuture(){
   Future.delayed(Duration(seconds: 5),(){
    incrementnumber();
    d();
    dddd();
    print("5 sec later");
    setState((){});
   });
}

  void updateCounter(){
   timer = Timer.periodic(Duration(milliseconds: 5), (timer) {
     incrementnumber();
     d();
     dddd();
     setState((){});
   });
 }
 
 void stopCounter(){
   timer.cancel();
 }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        body: getBody()
    )
    );
  }
  Widget getBody(){
    return Column(
      children: [
      topHeader(),
        Expanded(child: getContainer())
      ],
    );
  }
  Widget topHeader(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TopHeader(show:true,icon:Icons.info_outline,text: "fd",ontap: (){
          Navigator.pop(context);
        },),
        Row(
          children: [
            CustomSmallButton(icon:Icons.refresh,ontap: (){
              setState((){

              });
               },),
            SizedBox(width: 10,),
            CustomSmallButton(icon:Icons.close,ontap: (){

              setState((){});
            },),
            SizedBox(width: 10,),

          ],
        )
      ],
    );
  }

  Widget getContainer(){
    return Row(
      children: [
        Expanded(
            flex: 7,
            child: getGraph()),
        Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(child: getFlowGraph()),
                Expanded(child: getPressureGraph()),
                Expanded(child: Row(
                  children: [
                    Expanded(child: gethalfgraph(ispressue: true)),
                    Expanded(child: gethalfgraph(ispressue: false))
                  ],
                ))
              ],
            ))
      ],
    );
  }
  Widget getGraph(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
      child: LineChart(
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
                      titleText: "Time",
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
              lineBarsData: [
                LineChartBarData(
                    spots: flSpotList,
                    colors: [Colors.blueAccent]
                ),
              ]
          )

      ),
    );
  }

  Widget getFlowGraph(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
      child: LineChart(
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
                      titleText: "Flow +(cfm)",
                      textStyle: TextStyle(
                          fontSize:isDarkGraph ?30: 20,
                          color: isDarkGraph ? Colors.black : Colors.white
                      )
                  ),
                  bottomTitle: AxisTitle(
                      showTitle: true,
                      titleText: "Time",
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
              lineBarsData: [
                LineChartBarData(
                    spots: flSpotListFlow,
                    colors: [Colors.blueAccent]
                ),
              ]
          )

      ),
    );
  }

  Widget getPressureGraph(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
      child: LineChart(
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
                      titleText: "Presure +(torr)",
                      textStyle: TextStyle(
                          fontSize:isDarkGraph ?30: 20,
                          color: isDarkGraph ? Colors.black : Colors.white
                      )
                  ),
                  bottomTitle: AxisTitle(
                      showTitle: true,
                      titleText: "Time",
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
              lineBarsData: [
                LineChartBarData(
                    spots: flSpotListPressure,
                    colors: [Colors.blueAccent]
                ),
              ]
          )

      ),
    );
  }

  Widget gethalfgraph({required bool ispressue,double pressure=10.0,double flow=0.0}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      color: AppColors.greyColor,
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonText(text:ispressue ? 'Pressure' : 'Flow',color: Colors.white,),
            ],
          ),

           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               CommonText(text:ispressue ? '${dd}' : '${ddd}',color: Colors.white,fontSize: 20,),
               SizedBox(width: 5,),
               CommonText(text:ispressue ? 'psi' : 'sccm',color: Colors.white,)
             ],
           ),
          SizedBox(height: 10,),
          Stack(
            children: [
              SleekCircularSlider(

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
                initialValue:ispressue ? dd : ddd,
               // initialValue: ispressue ? pressure : flow ,
                onChange: (double value){
                  print(value);
                },
              ),
              Positioned(
                top: 95,
                left: 30,
                  right: 0,
                  child: Row(children: [
                    CommonText(text: ispressue? '0' :'0',color: Colors.white,),
                    ispressue ? SizedBox(width: 70,):SizedBox(width: 50,),
                    CommonText(text: ispressue? '2' :'100',color: Colors.white,)
              ],))
            ],
          ),


        ],
      ),
    );
  }
}

