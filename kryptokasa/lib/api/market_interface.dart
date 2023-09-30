import 'exchangeInfo.dart';

abstract class Market {
  Future<ExchangeInfo?> getValueInfo(String imputCurrency);
}
