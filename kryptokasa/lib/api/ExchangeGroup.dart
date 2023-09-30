import 'exchangeInfo.dart';

class ExchangeGroup{ // class group of exchanges
  List<ExchangeInfo> exchangeInfos;

  late String inputCurrency;
  late String outputCurrency;
  late int rateCountUsedToCalculateRate=0;
  late double rate;

  late String log="";

  ExchangeGroup.usd2pln(this.exchangeInfos){ // Constructor for usd2pln
    inputCurrency="USD";
    outputCurrency="PLN";
    rate=calculateRate(exchangeInfos.map((e) => double.parse(e.exchangeRate)).toList());
  }

  ExchangeGroup.eur2pln(this.exchangeInfos){ // Constructor for euro2pln
    inputCurrency="EUR";
    outputCurrency="PLN";
    rate=calculateRate(exchangeInfos.map((e) => double.parse(e.exchangeRate)).toList());
  }

  ExchangeGroup(this.exchangeInfos, ExchangeGroup usd2pln_exchageGroup, ExchangeGroup eur2pln_exchangeGroup){ // Constructor for any other currency
    inputCurrency=exchangeInfos[0].outputCurrency;
    //todo: make sure that all exchangeInfo have the same inputCurrency (but they probably will anyway)

    List<double> rates=exchangeInfos.map(
      (e) => double.parse(e.exchangeRate) 
      * (e.outputCurrency=="USD" ? usd2pln_exchageGroup.rate : e.outputCurrency=="EUR" ? eur2pln_exchangeGroup.rate : 1)
      ).toList();
    rate=calculateRate(rates);
  }

  double getMean(List<double> rates){
    double sum = 0;
    for (double rate in rates){
      sum+=rate;
    }
    double mean = sum/rates.length;
    return mean;
  }
  double getStandardDeviation(List<double> rates){
    double mean = getMean(rates);
    double sumOfSquares = 0;
    for (double rate in rates){
      sumOfSquares+=(rate-mean)*(rate-mean);
    }
    double standardDeviation = sumOfSquares/rates.length;
    return standardDeviation;
  }
  double calculateRate(List<double> rates){
    
    //calculate standard deviation
    double standardDeviation = getStandardDeviation(rates);

    //remove outliers (all the values that are more than 2 standard deviation away from the mean)
    List<double> ratesWithoutOutliers = [];
    double mean = getMean(rates);
    for (double rate in rates){
      if (rate<mean+2*standardDeviation && rate>mean-2*standardDeviation){
        ratesWithoutOutliers.add(rate);
        rateCountUsedToCalculateRate++;
      }
    }
    
    //calculate mean of the remaining values
    double meanWithoutOutliers = getMean(ratesWithoutOutliers);
    return meanWithoutOutliers;
  }
}