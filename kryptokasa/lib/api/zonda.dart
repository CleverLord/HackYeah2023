import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'market_interface.dart';
import 'api.dart';

const String zondaCrypto = 'https://api.zondacrypto.exchange/rest/trading/ticker/';

class ZondaMarket implements Market {
  @override
  Future<ExchangeInfo?> getValueInfo(String currency, String amount) async {
    String webData;
    final uri = '$zondaCrypto$currency-PLN';
    try {
      final response = await http.get(Uri.parse(uri)).timeout(const Duration(seconds: 5));
    if (response.statusCode != 200) {
      return null;
    }
    webData = response.body;
  } on TimeoutException catch (e) {
    return null;
  }

  final parsed = jsonDecode(webData) as Map<String, dynamic>;
  final status = parsed['status'];
  if (status != 'Ok') {
    return null;
  }
  final ticker = (parsed['ticker'] as Map<String,dynamic>);
  final rate = ticker['lowestAsk'].toString();
  return ExchangeInfo(uri, "Zonda", currency, "PLN", rate);
  }
}