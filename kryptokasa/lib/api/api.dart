import 'dart:async';

List<Future<ExchangeInfo?>Function()> markets = [

];

class ExchangeInfo {
  ExchangeInfo(this.marketUrl, this.marketName, this.inputCurrency, this.exchangeCurrency, this.exchangeRate);

  String marketName; // the name of the market
  String marketUrl; // the link to the market
  String inputCurrency;
  String exchangeCurrency; 
  String exchangeRate; // the exchange rate from InputCurrency to ExchangeCurrency (TargetCurrency is always PLN)
}