import 'package:bitcointickerfinal/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'api/dailydata.dart';
import 'api/hourlydata.dart';


class AnalyticScreen extends StatelessWidget {

  final String coinName ;
  final String symbolName;
  String currentPrice = '';
  String currency = '' ;


  List<List<DataPoint<DateTime>>> dailyDataList  = [];
//  List<List<DataPoint<DateTime>>> hourlyDataList = [];
// get daily data low dailyDataList[2]



  AnalyticScreen({this.coinName, this.symbolName, this.currentPrice, this.currency, this.dailyDataList});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(icon: Icon(Icons.arrow_back),
                                onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Color(0xFF40E0D0),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Text('$coinName  ($symbolName)', style: GoogleFonts.arimo(fontSize: 25, fontWeight: FontWeight.w800 )),
            ),

            centerTitle: true,

            bottom: TabBar(
              indicatorColor: Colors.white70,
              tabs: [
                Tab(child: Text("DAILY", style: TextStyle(fontSize: 17),),),
                Tab(child: Text("HOURLY",style: TextStyle(fontSize: 17),),)
              ],
            ),
          ),

          body: TabBarView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: ListView(
                        children: <Widget>[

                          SizedBox(height: 30,),

                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Current Price ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w800
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  Text(currentPrice,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w800
                                    ),
                                  ),


                                ],

                              ),
                            ),

                            decoration: BoxDecoration(
                                color: Color(0xFF40E0D0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )
                            ),


                          ),

                          SizedBox(height: 10,),

                          /* Check if the data point list points to null */
                          dailyDataList[0] != null ? Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 1.8,
                            child: BezierChart(

                              fromDate: DateTime.fromMillisecondsSinceEpoch(
                                num.parse("1604016000" + "000"),
                              ),

                              toDate: DateTime.fromMillisecondsSinceEpoch(
                                num.parse("1604880000" + "000"),
                              ),

                              bezierChartScale: BezierChartScale.WEEKLY,
                              series:  [
                                BezierLine(
                                  label: "Open",
                                  data: this.dailyDataList[0],
                                  lineColor: Colors.black38,
                                  lineStrokeWidth: 3,
                                ),

                                BezierLine(
                                  label: "Low",
                                  data: this.dailyDataList[2],
                                  lineColor: Colors.redAccent,
                                  lineStrokeWidth: 3,
                                ),

                                BezierLine(
                                  label: "High",
                                  data: this.dailyDataList[1],
                                  lineColor: Colors.lightGreenAccent,
                                  lineStrokeWidth: 3,
                                ),
                              ],

                              config: BezierChartConfig(
                                bubbleIndicatorColor: Color(0xFF007ac1),
                                bubbleIndicatorValueStyle: TextStyle(color: Colors.white),
                                bubbleIndicatorLabelStyle: TextStyle(color: Colors.white),
                                bubbleIndicatorTitleStyle: TextStyle(color: Colors.white),
                                verticalIndicatorStrokeWidth: 1.0,
                                showDataPoints: true,
                                verticalIndicatorColor: Colors.black,
                                showVerticalIndicator: true,
                                verticalIndicatorFixedPosition: false,
                                backgroundColor: Colors.white,
                                footerHeight: 50,
                                displayLinesXAxis: true,
                                pinchZoom: true,
                                xLinesColor: Colors.red,
                                xAxisTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                ),
                                snap: true,
                              ),
                            ) ,
                          ) : Container(),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
    //                    borderRadius: BorderRadius.only(
    //                      topLeft: Radius.circular(30.0),
    //                      topRight: Radius.circular(30.0),
    //                    ),
                      ),
                    ),
                  ),
                ],
              ),

              // Next TAB BAR
              Text('This Page Is Still In Progress'),

            ],
          )
        ),
      ),
    );
  }
}
