import 'package:decimal/decimal.dart';

class ExchangeInfo {
  ExchangeInfo(this.marketUrl, this.marketName, this.exchangeCurrency, this.exchangeRate);
  ExchangeInfo.fail(this.isSuccess, this.isReached, this.marketUrl, this.marketName, { this.exchangeRate = '0', this.exchangeCurrency = '0'});

  bool isReached = true;
  bool isSuccess = true;
  String marketName; // the name of the market
  String marketUrl; // the link to the market
  String exchangeCurrency; //USD, EUR, PLN
  String exchangeRate = '0';
  String exchangeValue = '0';
  String polishValue = '0';

  static ExchangeInfo copy (ExchangeInfo info) {
    final clone = ExchangeInfo(info.marketUrl, info.marketName, info.exchangeCurrency, info.exchangeRate);
    clone.isSuccess = info.isSuccess;
    clone.isReached = info.isReached;
    clone.polishValue = info.polishValue;

    return clone;
  }

  void calcValue (String rate, String amount) {
    final excVal = Decimal.parse(amount) * Decimal.parse(exchangeRate);

    exchangeValue = excVal.toString();
    
    if (exchangeCurrency == 'PLN') {
      polishValue = exchangeRate;
      return;
    }

    final val = Decimal.parse(rate) * Decimal.parse(exchangeValue);

    polishValue = val.toString();
  }
}