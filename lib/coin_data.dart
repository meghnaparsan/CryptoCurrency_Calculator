import 'package:http/http.dart' as http;
import 'dart:convert';

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

const coinAPI = 'https://rest.coinapi.io/v1/exchangerate';

//TODO: API KEY
const apiKey = 'YOUR-API-KEY';

class CoinData {
  CoinData();

  Future<Map<String, String>> getCoinData(String currency) async {
    Map<String, String> coinData = {};

    for (String cryptoCoin in cryptoList) {
      String url = '$coinAPI/$cryptoCoin/$currency?apikey=$apiKey';
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var rate = decodedData['rate'];
        String roundedRate = rate.toStringAsFixed(1);
        coinData[cryptoCoin] = roundedRate;
      }
    }

    return coinData;
  }
}
