// remove the unused imports later.
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'coin_data.dart';
import 'dart:io' show Platform ;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:crypto_font_icons/crypto_font_icon_data.dart';
import 'coin_card.dart';
import 'coin_data.dart';
import 'analytics_screen.dart';

List<String> coinList   = ["Bitcoin", "Ethereum", "Litecoin", "Ripple", "Ethereum Classic", "DASH", "Amp"];
List<String> symbol  = ["BTC", "ETH", "LTC", "XRP", "ETC", "DASH", "AMP"];
List<IconData> iconList = [
  CryptoFontIcons.BTC_ALT,
  CryptoFontIcons.ETH,
  CryptoFontIcons.LTC,
  CryptoFontIcons.XRP,
  CryptoFontIcons.ETC,
  CryptoFontIcons.DASH,
  CryptoFontIcons.AMP,
];

final List<Color> colors = <Color>[Colors.orange, Colors.black, Colors.blue, Colors.black38, Colors.green, Colors.blue, Colors.redAccent];

class MarketScreen extends StatefulWidget {
  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {

  final TextEditingController _controller = new TextEditingController();

  String currency = 'MYR';
  Map<String, String> coinValues = {};
  Map<String, String> percentChg = {};

  List<String> coinFilterList;
  List<String> symbolFilterList;
  List<IconData> iconFilterList;
  List<Color> colorsFilterList;


  @override
  void initState() {
    super.initState();
    getData('MYR');
    print('Get Data.. ');
//    getData();
  }




//  void getData() async {
//
//    String url = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC&tsyms=MYR";
//    String apiKey = "167312fa39c0f51679539c414e6f85d8789cd405e00f8708f69e1fb7c1731866";
//    String requestURL = '$url&api_key=$apiKey';
//    http.Response response = await http.get(requestURL);
//
//    if (response.statusCode == 200) {
//      String data = response.body;
//      print(data);
//
//      var decodedData = jsonDecode(data);
//
//      print("Decoding now");
//      print(decodedData['RAW']['BTC']['MYR']['PRICE']);
//      print("\n");
//    }
//  }

  bool checkPositive(String figure){

    bool isPositive = false ;

    if ( figure != null && double.parse(figure) > 0 ){
      isPositive  = true ;}

    return isPositive;
  }

  /// Get relevant data from the coin class.
  void getData(String selectedCurrency) async{
    try{
      CoinData coinData = CoinData();
      dynamic prices      = await coinData.getCoinPrice(selectedCurrency);
      dynamic priceChange = await coinData.getPercentChg24Hours(selectedCurrency);

      setState(() {
        coinValues = prices;
        percentChg = priceChange;

        print(percentChg);
      });

    } catch(e){
      print(e);
    }
  }

    void filterCurrency({String text}) {
      coinFilterList = [];
      symbolFilterList = [];
      iconFilterList = [];
      colorsFilterList = [];

      for (int index = 0; index < coinList.length; index++) {
        if (coinList[index].toLowerCase().contains(text.toLowerCase())) {
          coinFilterList.add(coinList[index]);
          symbolFilterList.add(symbol[index]);
          iconFilterList.add(iconList[index]);
          colorsFilterList.add(colors[index]);
        }
      }
    }

    @override
    Widget build(BuildContext context) {
      if (coinFilterList == null && symbolFilterList == null) {
        filterCurrency(text: '');
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('Market', style: TextStyle(fontSize: 25),),
          backgroundColor: Color(0xFF40E0D0),
        ),

        body: Column(
          children: <Widget>[
            Container(
              height: 95.0,
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                  decorationColor: Colors.black,
                ),
                controller: _controller,
                onChanged: (String text) {
                  setState(() {
                    // filter the currencies based on user input
                    filterCurrency(text: text);
                  });
                },
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  hintText: 'Search currency',
                  hintStyle: TextStyle(
                      color: Colors.blueGrey
                  ),
                  icon: Icon(Icons.search, color: Colors.black, size: 25.0,),
                ),
              ),
              padding: EdgeInsets.all(25.0),
            ),

            Divider(
              height: 2.0,
              thickness: 1.0,
              color: Colors.grey[350],
            ),


            // this will illustrate the list tiles for cryptocurrency
            Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.all(10),
                  itemCount: coinFilterList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AnalyticScreen(coinName: coinFilterList[index],
                                                   symbolName: symbolFilterList[index] ,
                                                   currentPrice: '${coinValues[symbolFilterList[index]]} $currency',
                                    )
                              )
                          );
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            iconFilterList[index],
                            color: colorsFilterList[index],
                          ),

                        ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,

                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                '${coinValues[symbolFilterList[index]]} $currency',
                                style: TextStyle(color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            SizedBox(width: 10.0,),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                              child: Text(
                                '${percentChg[symbolFilterList[index]]} %', style: TextStyle(
                                  color: checkPositive(percentChg[symbolFilterList[index]]) ? Colors.green : Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              ),
                            ),

                          ],
                        ),

                        title: Text(
                          '${coinFilterList[index]}',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 19),
                        ),

                        subtitle: Text('${symbolFilterList[index]}',
                          style: TextStyle(color: Colors.blueGrey,
                              fontWeight: FontWeight.w500),),

                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                        height: 2.0,
                        thickness: 1.0,
                        color: Colors.grey[350],
                      )
              ),
            ),


          ],
        ),


      );
    }
  }
