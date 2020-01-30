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
];

String url = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class CoinData {
  String selectedCurrency = '';

  /// There will be three different response body in this list.
  /// Can only unlock via the 'KEY', that is BTC, ETH, LTC.
  Map<String, String> cryptoPrices = {};

  Future getCoinData(String selectedCurrency) async{

    for (String crypto in cryptoList){
      String requestURL = '$url/$crypto$selectedCurrency';
      http.Response response = await http.get(requestURL);

      if (response.statusCode == 200){
        String data = response.body;
        var decodedData = jsonDecode(data);

        /// Map the crypto currency's price to the crypto currency name.
        cryptoPrices[crypto] = decodedData['last'].toString() ;
      } else {
        print(response.statusCode);
        return;
      }
    }

    /// If all retrieval was successful, then return the MAP LIST.
    return cryptoPrices ;

  }
}
