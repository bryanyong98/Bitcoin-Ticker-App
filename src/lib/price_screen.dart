import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'coin_data.dart';
import 'dart:io' show Platform ;

/// The UI for the Bitcoin App.

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'USD';
  String BTCValue = '0.00' ;  /// this stores the last value from the API.
  String ETHValue = '0.00' ;  /// this stores the last value from the API.
  String LTCValue = '0.00' ;  /// this stores the last value from the API.
  Map<String, String> coinValues = {};


  @override
  void initState() {
    super.initState();
    getData(selectedCurrency);
  }

  /// Get relevant data from the coin class.
  void getData(String selectedCurrency) async{
    try{
      CoinData coinData = CoinData();
      dynamic data = await coinData.getCoinData(selectedCurrency);
      print(data);

      setState(() {
        coinValues = data;
      });

    } catch(e){
      print(e);
    }
  }


  /// Method for calling the Android component button.
  DropdownButton<String> androidButton(){

    List<DropdownMenuItem<String>> dropdownItems = [];

    for (int i = 0 ; i < currenciesList.length; i++){
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged:(value){
        setState(() {
          selectedCurrency = value;
          getData(selectedCurrency);
        });
        print(value);
      },
    );
  }

  /// Method for calling the IOS component.
  CupertinoPicker iOSPicker(){

    /// pouring all the picker items in a list, then
    List<Text> pickerItems = [];
    for (String currency in currenciesList){
      pickerItems.add(Text(currency));
    }

    /// place the list items in the Cupertino picker
    return CupertinoPicker(
      backgroundColor: Colors.lightBlueAccent,
      itemExtent: 32.0,
      onSelectedItemChanged:(selectedIndex){
        print(selectedIndex) ;
        getData(selectedIndex.toString());

      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${coinValues['BTC']} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          /// Second Display based on Ethereum, ETH crypto currency.
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = ${coinValues['ETH']} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          /// Third Display based on Litecoin, LTC crypto currency.
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = ${coinValues['LTC']} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidButton()  ,
          )
        ],
      ),
    );
  }
}
