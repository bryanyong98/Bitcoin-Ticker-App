import 'package:http/http.dart' as http;
import 'dart:convert';

/// All backend implementation of the Bitcoin Application.
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MYR',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'XRP',  // Ripple
  'ETC',  // Ethereum Classic
  'DASH', // Dash
  'AMP',  //
  'BCH'   // Bitcoin cash
];

//String url   = 'https://rest-sandbox.coinapi.io/v1/exchangerate';
//String apiKey = "AED24F73-EF8C-4ED3-AA71-AF55A61C7AC5" ;

String apiKey = "167312fa39c0f51679539c414e6f85d8789cd405e00f8708f69e1fb7c1731866";

class CoinData {


  /// There will be three different response body in this list.
  /// Can only unlock via the 'KEY', that is BTC, ETH, LTC.
  Map<String, String> cryptoPrices = {};
  Map<String, String> percentChg   = {};



  //String requestURL = '$url/$crypto/$selectedCurrency?apikey=$apiKey';
//  String requestURL = '$url&api_key=$apiKey';

  Future getCoinPrice(String selectedCurrency) async{

    for (String crypto in cryptoList){
      String url = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$crypto&tsyms=$selectedCurrency";
      String requestURL = '$url&api_key=$apiKey';
      http.Response response = await http.get(requestURL);

      if (response.statusCode == 200){
        String data = response.body;

        var decodedData = jsonDecode(data);

        /// Map the crypto currency's price to the crypto currency name.
        cryptoPrices[crypto] = decodedData['RAW']['$crypto']['$selectedCurrency']['PRICE'].toStringAsFixed(2) ;

      } else {
        print(response.statusCode);
        return; }
    }

    /// If all retrieval was successful, then return the MAP LIST.
    return cryptoPrices ;
  }


  Future getPercentChg24Hours(String selectedCurrency) async{

    for (String crypto in cryptoList){
      String url = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$crypto&tsyms=$selectedCurrency";
      String requestURL = '$url&api_key=$apiKey';

      http.Response response = await http.get(requestURL);

      if (response.statusCode == 200){
        String data = response.body;

        var decodedData = jsonDecode(data);

        print("Decoding now");
//        print(decodedData);
//        decodedData['RAW']['BTC']['MYR']['PRICE']

        /// Map the crypto currency's price to the crypto currency name.
        percentChg[crypto] = decodedData['RAW']['$crypto']['$selectedCurrency']['CHANGEPCT24HOUR'].toStringAsFixed(2) ;

      } else {
        print(response.statusCode);
        return;
      }

    }

    /// If all retrieval was successful, then return the MAP LIST.
    return percentChg ;
  }

}
