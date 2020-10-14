import 'package:crypto_calculator/drop_down_items.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  DropDownItem items = DropDownItem();
  CoinData coinData = CoinData();
  Map<String, String> convertedRates = {};
  bool isWaiting = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    isWaiting = true;
    try {
      Map<String, String> rates = await coinData.getCoinData(currency);
      isWaiting = false;
      setState(() {
        convertedRates = rates;
      });
    } catch (e) {
      print(e);
    }
  }

  String cryptoCoin = 'BTC';
  String currency = 'INR';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COIN TICKER',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CoinCard(
                    convertedRate: isWaiting ? '?' : convertedRates['BTC'],
                    bitCoin: 'BTC',
                    currency: currency,
                  ),
                  CoinCard(
                    convertedRate: isWaiting ? '?' : convertedRates['LTC'],
                    bitCoin: 'LTC',
                    currency: currency,
                  ),
                  CoinCard(
                    convertedRate: isWaiting ? '?' : convertedRates['ETH'],
                    bitCoin: 'ETH',
                    currency: currency,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Color(0xff69779b),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      elevation: 16,
                      items: items.addWorldCurrency(),
                      value: currency,
                      onChanged: (selectedValue) {
                        setState(() {
                          currency = selectedValue;
                          getData();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoinCard extends StatelessWidget {
  final String bitCoin;
  final String currency;
  final String convertedRate;

  CoinCard({this.bitCoin, this.currency, this.convertedRate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Color(0xff69779b),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $bitCoin = $convertedRate $currency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
