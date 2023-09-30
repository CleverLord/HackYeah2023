import 'dart:async';
import 'package:kryptokasa/api/npb.dart';
import 'package:kryptokasa/api/zonda.dart';

import 'exchangeInfo.dart';
import 'market_interface.dart';
import 'ExchangeGroup.dart';

Future<CryptoResult> ProcessTask(CryptoTask task) async { // main function, which is called from UI

  CryptoResult result = CryptoResult();

  //iterate through all the tasks and give them indexes
  for (int i = 0; i < task.cryptoPairs.length; i++){
    task.cryptoPairs[i].index = i;
  }

  //go through all the rows in the task and get all unique input currencies
  List<String> inputCurrencies = task.cryptoPairs.map((e) => e.inputCurrency).toSet().toList();
  
  //For next step we will need USD to PLN exchange rate
  List<ExchangeInfo?> usdToPlnNullable = await Future.wait(markets.map((e) => e.getValueInfo("USD")));
  usdToPlnNullable.removeWhere((element) => element == null);
  List<ExchangeInfo> usdToPln = usdToPlnNullable.map((e) => e!).toList();
  ExchangeGroup usdToPlnGroup = ExchangeGroup.usd2pln(usdToPln);
  result.usd2pln_exchangeGroup = usdToPlnGroup;

  //Same for Euro to PLN
  List<ExchangeInfo?> eurToPlnNullable = await Future.wait(markets.map((e) => e.getValueInfo("EUR")));
  eurToPlnNullable.removeWhere((element) => element == null);
  List<ExchangeInfo> eurToPln = eurToPlnNullable.map((e) => e!).toList();
  ExchangeGroup eurToPlnGroup = ExchangeGroup.eur2pln(eurToPln);
  result.eur2pln_exchangeGroup = eurToPlnGroup;

  //for each input currency, create a ExchangeGroup
  for ( var inputCurrency in inputCurrencies){
    List<ExchangeInfo?> exchangesNullable = await Future.wait(markets.map((e) => e.getValueInfo(inputCurrency)));
    exchangesNullable.removeWhere((element) => element == null);
    List<ExchangeInfo> exchanges = exchangesNullable.map((e) => e!).toList();
    ExchangeGroup exchangeGroup = ExchangeGroup(exchanges, usdToPlnGroup, eurToPlnGroup);

    //find all of the tasks with this input currency
    List<CryptoPair> tasks = task.cryptoPairs.where((element) => element.inputCurrency == inputCurrency).toList();
    //for each task, create CryptoConversion
    for (var task in tasks){
      CryptoConversion cryptoConversion = CryptoConversion(task, exchangeGroup, (double.parse(task.amount)*exchangeGroup.rate).toString());
      result.cryptoConversions.add(cryptoConversion);
    }
  }

  //sort so that it was in the same order as on the UI
  result.cryptoConversions.sort((a, b) => a.task.index.compareTo(b.task.index));

  return result;
}

//List representing all available markets
List<Market> markets = [
  NBPMarket(),
  ZondaMarket()
];

class CryptoTask{ // class reprezenting UI input panel
  late List<CryptoPair> cryptoPairs;
}
class CryptoPair{ // class representing single input row
  String inputCurrency;
  String amount;
  late int index; //I should really not store this in here, but it's soo convenient
  CryptoPair(this.inputCurrency, this.amount);
}

class CryptoResult{ // class representing single output row
  late List<CryptoConversion> cryptoConversions;
  late ExchangeGroup usd2pln_exchangeGroup;
  late ExchangeGroup eur2pln_exchangeGroup;
  //Todo, Mateusz: add more field you would like to display
}
class CryptoConversion{
  CryptoPair task;
  ExchangeGroup exchangeGroup;
  String resultAmount;
  CryptoConversion(this.task, this.exchangeGroup, this.resultAmount);
}