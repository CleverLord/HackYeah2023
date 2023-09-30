import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kryptokasa/api/crypto_info.dart';

const String zondaCrypto = 'https://api.zondacrypto.exchange/rest/trading/ticker/';

Future<CryptoInfo?> getCryptoInfo(String currency) async {
  late String data;
  try {
    final uri = '$zondaCrypto$currency-PLN';
    final response = await http.get(Uri.parse(uri)).timeout(const Duration(seconds: 5));

    if (response.statusCode != 200) {
      return null;
    }

    data = response.body;

  } on TimeoutException catch (e) {
    return null;
  }

  final parsed = jsonDecode(data) as Map<String, dynamic>;

  final status = parsed['status'];

  if (status != 'Ok') {
    return null;
  }

  final ticker = (parsed['ticker'] as Map<String,dynamic>);
  final rate = ticker['lowestAsk'].toString();

  final info = CryptoInfo('PLN', rate);

  return info;
}