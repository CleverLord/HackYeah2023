import 'dart:async';
import 'dart:collection';

import 'package:kryptokasa/api/currency_info.dart';
import 'package:kryptokasa/api/nbp.dart' as nbp;
import 'package:kryptokasa/api/markets/zonda.dart' as zonda;
import 'package:kryptokasa/api/markets/gemini.dart' as gemini;

import 'exchangeInfo.dart';
import 'package:decimal/decimal.dart';

List<Future<ExchangeInfo> Function (String)> _exchangeMarkets = [
  zonda.getValueInfo,
  gemini.getValueInfo
];

Future<CryptoResult> ProcessTask(CryptoTask task) async {
  // main function, which is called from UI

  final HashMap<String, CurrencyInfo?> exchangeNbp = HashMap.from({
    'USD': null,
    'EUR': null
  });
  String tableDate = 'Nie udało się pobrać tabeli NBP.';

  List<Future<CurrencyInfo?>> jobs = [];
  exchangeNbp.forEach((key, value) {
    Future<CurrencyInfo?> exchange = nbp.getValueInfo(key);
    jobs.add(exchange);
  });

  //fetch nbp exchange data
  for (Future<CurrencyInfo?> element in jobs) {
    CurrencyInfo? info = await element;
    if (info != null) {
      tableDate = info.tableDate;
      exchangeNbp[info.code] = info;
    }
  }

  final HashSet<String> cryptoTypes = HashSet();

  final orders = task.cryptoPairs;

  //create crypto request list (remove duplicates)
  for (CryptoPair order in orders) {
    cryptoTypes.add(order.inputCurrency);
  }

  HashMap<String, List<ExchangeInfo>> inquiries = HashMap();

  for (String crypto in cryptoTypes) {
    if (inquiries.containsKey(crypto)) {
      continue;
    }

    List<Future<ExchangeInfo>> requestTasks = [];

    for (final market in _exchangeMarkets) {
      requestTasks.add(market(crypto));
    }

    final List<ExchangeInfo> exchangeRates = await Future.wait(requestTasks);

    inquiries.putIfAbsent(crypto, () => exchangeRates);
  }

  //return data
  List<CryptoConversion> conversions = List.generate(orders.length, (index) {
    final order = orders[index];



    final List<ExchangeInfo> inf = [];
    final exi = inquiries[order.inputCurrency];

    if (exi != null) {
      for (ExchangeInfo ex in exi) {
        final curInfo = exchangeNbp[ex.exchangeCurrency];

        String rate = '0';

        if (curInfo != null) {
          rate = curInfo.rate;
        }

        ExchangeInfo e = ExchangeInfo.copy(ex);
        e.calcValue(rate, order.amount);
        inf.add(e);
      }
    }

    final conv = CryptoConversion(order, inf);
    
    return conv;
  });

  CryptoResult result = CryptoResult();

  result.tableDate =tableDate;
  result.plnExchange = exchangeNbp;
  result.cryptoConversions = conversions;

  return result;
}

class CryptoTask {
  // class reprezenting UI input panel
  late List<CryptoPair> cryptoPairs;
}

class CryptoPair {
  // class representing single input row
  String inputCurrency;
  String amount;
  late int index; //I should really not store this in here, but it's soo convenient
  CryptoPair(this.inputCurrency, this.amount);
}

class CryptoResult {
  // class representing single output row
  late String tableDate;
  late HashMap<String, CurrencyInfo?> plnExchange;
  late List<CryptoConversion> cryptoConversions=[];

  //Todo, Mateusz: add more field you would like to display
}

class CryptoConversion {
  CryptoConversion(this.task, this.exchangeInfos);
  final CryptoPair task;
  final List<ExchangeInfo> exchangeInfos;
}
