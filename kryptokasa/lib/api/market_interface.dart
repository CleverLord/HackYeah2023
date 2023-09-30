import 'api.dart';

abstract class Market {
  Future<ExchangeInfo?> getValueInfo(String currency, String amount);
}
