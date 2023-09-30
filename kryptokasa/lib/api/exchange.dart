import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

final Uri exchangeEndPoint = Uri.parse('http://api.nbp.pl/api/exchangerates/rates/c/usd/');

class ExchangeInfo {
  ExchangeInfo(this.code, this.currency, this.rate, this.date);

  String code;
  String currency;
  String rate;
  String date;
}

Future<ExchangeInfo?> getExchangeRate() async {
  late String data;
  try {
    final response = await http.get(exchangeEndPoint).timeout(const Duration(seconds: 5));

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
  final currency = parsed['currency'].toString();
  final date = rates['effectiveDate'].toString();
  final rate = rates['bid'].toString();

  final info = ExchangeInfo(code, currency, rate, date);

  return info;
}