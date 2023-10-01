import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../exchangeInfo.dart';

const String _zondaName = "zondacrypto";
const String _zondaUrl = "https://zondacrypto.com/pl/home";
const String _zondaCrypto = 'https://api.zondacrypto.exchange/rest/trading/ticker/';

Future<ExchangeInfo> getValueInfo(String inputCurrency) async {
  String webData;
  final uri = '$_zondaCrypto$inputCurrency-PLN';
  try {
    final response = await http.get(Uri.parse(uri)).timeout(const Duration(seconds: 5));
    if (response.statusCode != 200) {
      return ExchangeInfo.fail(false, false, _zondaUrl, _zondaName);
    }
    webData = response.body;
  } on TimeoutException catch (e) {
    return ExchangeInfo.fail(false, false, _zondaUrl, _zondaName);
  }

  final parsed = jsonDecode(webData) as Map<String, dynamic>;
  final status = parsed['status'];
  if (status != 'Ok') {
    return ExchangeInfo.fail(false, true, _zondaUrl, _zondaName);
  }
  final ticker = (parsed['ticker'] as Map<String, dynamic>);
  final rate = ticker['highestBid'].toString();
  return ExchangeInfo(_zondaUrl, _zondaName, "PLN", rate);
}
