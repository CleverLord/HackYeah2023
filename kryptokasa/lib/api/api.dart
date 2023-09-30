import 'dart:async';
import 'package:kryptokasa/api/npb.dart';
import 'package:kryptokasa/api/zonda.dart';

import 'exchangeInfo.dart';

//List representing all available markets
List<Future<ExchangeInfo?>Function(String inputCurrency)> markets = [
  NBPMarket().getValueInfo,
  ZondaMarket().getValueInfo
];


class CryptoTask{ // class reprezenting UI input panel
  late List<CryptoPair> cryptoPairs;
}

class CryptoPair{ // class representing single input row
  String inputCurrency;
  String amount;
  CryptoPair(this.inputCurrency, this.amount);
}
