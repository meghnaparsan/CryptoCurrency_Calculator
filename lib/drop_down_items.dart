import 'package:flutter/material.dart';

import 'coin_data.dart';

class DropDownItem {
  List<DropdownMenuItem<String>> addWorldCurrency() {
    List<DropdownMenuItem<String>> worldCurrencies = [];
    for (String currency in currenciesList) {
      worldCurrencies.add(
        DropdownMenuItem<String>(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return worldCurrencies;
  }
}
