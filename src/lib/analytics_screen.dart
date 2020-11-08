import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';


class AnalyticScreen extends StatelessWidget {

  final String coinName ;
  final String symbolName;
  String currentPrice = '';

  AnalyticScreen({this.coinName, this.symbolName, this.currentPrice});


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
    //              Container(
    //                padding: EdgeInsets.only(
    //                    top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
    //                child: Column(
    //                  crossAxisAlignment: CrossAxisAlignment.start,
    //                  children: <Widget>[
    //                    SizedBox(
    //                      height: 10.0,
    //                    ),
    //                    Text(
    //                      '$coinName  ($symbolName)',
    //                      style: TextStyle(
    //                        color: Colors.white,
    //                        fontSize: 30.0,
    //                        fontWeight: FontWeight.w700,
    //                      ),
    //                    ),
    //
    //                  ],
    //                ),
    //              ),
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

                          // implement the switchable menu button
                          Row(
                            children: <Widget>[



    //                      Flexible(
    //                        flex: 2,
    //                        child: Padding(
    //                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //                            child: TabBar(
    //                              tabs : [
    //                                Text('Daily'),
    //                                Text('Hourly')
    //                              ],
    //                            ),
    //                        ),
    //                      ),
                            ],
                          ),


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
              Icon(Icons.email),

            ],
          )
        ),
      ),
    );
  }
}
