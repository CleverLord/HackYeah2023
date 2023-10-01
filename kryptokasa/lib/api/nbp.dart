import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kryptokasa/api/currency_info.dart';

const String exchangeEndPoint = 'http://api.nbp.pl/api/exchangerates/rates/c/';

Future<CurrencyInfo?> getValueInfo(String inputCurrency) async {
  late String data;
  final uri = '$exchangeEndPoint$inputCurrency/';
  try {
    final response = await http.get(Uri.parse(uri)).timeout(const Duration(seconds: 5));
    if (response.statusCode != 200) {
      return null;
    }
    data = response.body;
  } on TimeoutException catch (e) {
    return null;
  }

  final parsed = jsonDecode(data) as Map<String, dynamic>;
  final rates = (parsed['rates'] as List<dynamic>)[0] as Map<String, dynamic>;

  final code = parsed['code'].toString();
  final currencyName = parsed['currency'].toString();
  final date = rates['effectiveDate'].toString();
  final rate = rates['bid'].toString();

  final info = CurrencyInfo(code, currencyName, date, rate);
  return info;
}
