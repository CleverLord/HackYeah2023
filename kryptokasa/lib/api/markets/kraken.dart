import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../exchangeInfo.dart';

const String _marketName = "Kraken";
const String _marketUrl = "https://www.kraken.com/";
const String _marketCrypto = 'https://api.kraken.com/0/public/Ticker?pair=btcusd';

Future<ExchangeInfo> getValueInfo(String inputCurrency) async {
  inputCurrency = inputCurrency.toUpperCase();

  String webData;
  final uri = '$_marketCrypto${inputCurrency}EUR';
  try {
    final response = await http.get(Uri.parse(uri)).timeout(const Duration(seconds: 5));
    if (response.statusCode != 200) {
      return ExchangeInfo.fail(false, false, _marketUrl, _marketName);
    }
    webData = response.body;
  } on TimeoutException catch (e) {
    return ExchangeInfo.fail(false, false, _marketUrl, _marketName);
  }

  final parsed = jsonDecode(webData) as Map<String, dynamic>;
  final status = parsed['result'];

  if (status != null) {
    return ExchangeInfo.fail(false, true, _marketUrl, _marketName);
  }

  final rate = parsed['lowPrice'].toString();
  return ExchangeInfo(_marketUrl, _marketName, "EUR", rate);
}
