import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'exchangeInfo.dart';
import 'market_interface.dart';

final String exchangeEndPoint = 'http://api.nbp.pl/api/exchangerates/rates/c/';

class NBPMarket implements Market {
  @override
  Future<ExchangeInfo?> getValueInfo(String imputCurrency) async {
    late String data;
    final uri = '$exchangeEndPoint$imputCurrency/';
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
    final currency = parsed['currency'].toString();
    final date = rates['effectiveDate'].toString();
    final rate = rates['bid'].toString();

    final info = ExchangeInfo(exchangeEndPoint.toString(),"NBP",imputCurrency,"PLN",rate);
    return info;
  }
}
