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
      polishValue = roundToTwo(exchangeValue);
      return;
    }

    final val = Decimal.parse(rate) * Decimal.parse(exchangeValue);

    polishValue = val.toString();
    polishValue = roundToTwo(polishValue);
  }

  //Function that takes String, that contains a number and returns it as a String rounded to 2 decimal places
  //String might contain a dot, or a comma, or nothing
  //If there is nothing add .00
  String roundToTwo(String val) {
    final dot = val.indexOf('.');
    final comma = val.indexOf(',');

    if (dot == -1 && comma == -1) {
      return '$val.00';
    }

    if (dot != -1) {
      final afterDot = val.substring(dot + 1);
      if (afterDot.length == 1) {
        return '$val' + '0';
      }
      if (afterDot.length == 2) {
        return val;
      }
      return val.substring(0, dot + 3);
    }

    if (comma != -1) {
      final afterComma = val.substring(comma + 1);
      if (afterComma.length == 1) {
        return '$val' + '0';
      }
      if (afterComma.length == 2) {
        return val;
      }
      return val.substring(0, comma + 3);
    }

    return val;
  }
}