import 'dart:async';
import 'zonda.dart' as zonda;

List<Future<ValueInfo?>Function()> markets = [

];

Future<List<ValueInfo?>?> getValues (String currency, String amount) async{

  final zondaTask = await zonda.getCryptoInfo(currency);

  print (zondaTask?.rate);

  return null;
}

class ValueInfo {
  ValueInfo(this.marketUrl, this.marketName, this.value, this.polishValue, this.exchangeRate);

  String marketUrl;
  String marketName;
  String value;
  String polishValue;
  String exchangeRate;
}