// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:definitely_not_window/definitely_not_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kryptokasa/api/api.dart';
import 'package:kryptokasa/front/common.dart';
import 'package:kryptokasa/front/list_kryptoaktyw.dart';

import 'front/dropdown_naczelnicy.dart';
import 'front/table_legend.dart';

void main() {
  //ensure windowo initialised
  WidgetsFlutterBinding.ensureInitialized();

  onWindowReady(() {
    window.title = "Kryptokasa.GOV";
    window.minSize = const Size(1000, 500);
    window.show();
  });
  runApp(const MyApp());
}

int step = 1;

GlobalKey listKryptoaktywaKey = GlobalKey();
GlobalKey dropdownNaczelnicyKey = GlobalKey();
GlobalKey inputSprawaKey = GlobalKey();
GlobalKey inputWlascicielKey = GlobalKey();

bool isListKryptoaktywaValid = true;
bool isListKryptoaktywaValidPary = true;
bool isDropdownNaczelnicyValid = true;
bool isInputSprawaValid = true;
bool isInputWlascicielValid = true;

Future<CryptoResult>? cryptoConversionResult;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Headbar(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 240, 240, 245), Color.fromARGB(255, 255, 255, 255)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    //Title
                    Positioned(
                      top: 34.0,
                      left: 34.0,
                      child: Text(
                        "Kreator szacunkowych wartości kryptoaktyw",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    //Settings
                    Positioned(
                      top: 34.0,
                      right: 34.0,
                      child: Icon(
                        Icons.settings,
                        color: blue,
                        size: 34.0,
                      ),
                    ),
                    //History
                    Positioned(
                      top: 34.0,
                      right: 80.0,
                      child: Icon(
                        Icons.history,
                        color: blue,
                        size: 34.0,
                      ),
                    ),

                    const StepHeader(
                      top: 82.0,
                      left: 34.0,
                      text: "Krok 1/3 - Dane podstawowe",
                    ),
                    Positioned(
                      top: 114.0,
                      bottom: 34.0,
                      left: 34.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 34.0, horizontal: 22.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black12,
                            width: 1.0,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(1.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        width: 550, // Adjust the width as needed
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ...[
                                        const HeaderText("Organ Egzekucyjny"),
                                        const TooltipText(
                                            "Wybierz organ egzekucyjny, który będzie egzekwował zobowiązanie"),
                                        if (!isDropdownNaczelnicyValid)
                                          const ErrorText("Błąd: Organ egzekucyjny nie został wybrany"),
                                        padding(8),
                                        DropdownNaczelnicy(key: dropdownNaczelnicyKey),
                                        padding(12),
                                      ],
                                      ...[
                                        const HeaderText("Numer Sprawy"),
                                        const TooltipText(
                                            "Podaj numer sprawy, w której organ egzekucyjny wydał decyzję o zablokowaniu kryptoaktyw"),
                                        if (!isInputSprawaValid) const ErrorText("Błąd: Pole nie może być puste"),
                                        padding(8),
                                        CustomTextField(key: inputSprawaKey),
                                      ],
                                      ...[
                                        const HeaderText("Dane Właściciela/ki Kryptoaktyw"),
                                        const TooltipText("Podaj dane osoby której dotyczy wniosek."),
                                        if (!isInputWlascicielValid) const ErrorText("Błąd: Pole nie może być puste"),
                                        padding(8),
                                        CustomTextField(key: inputWlascicielKey),
                                      ],
                                      ...[
                                        const HeaderText("Lista Kryptoaktyw"),
                                        const TooltipText("Wybierz i podaj ilość kryptoaktyw do szacowania"),
                                        if (!isListKryptoaktywaValidPary)
                                          const ErrorText("Błąd: Nie wszystkie pola zostały wypełnione"),
                                        if (!isListKryptoaktywaValid)
                                          const ErrorText("Błąd: Brak kryptoaktyw do szacowania"),
                                        padding(8),
                                        ListKryptoaktyw(key: listKryptoaktywaKey),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            padding(8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    isListKryptoaktywaValid =
                                        (listKryptoaktywaKey.currentState! as ListKryptoaktywState).validate();
                                    isDropdownNaczelnicyValid =
                                        (dropdownNaczelnicyKey.currentState! as DropdownNaczelnicyState).validate();
                                    isInputSprawaValid =
                                        (inputSprawaKey.currentState! as CustomTextFieldState).validate();
                                    isInputWlascicielValid =
                                        (inputWlascicielKey.currentState! as CustomTextFieldState).validate();

                                    if (!isDropdownNaczelnicyValid ||
                                        !isInputSprawaValid ||
                                        !isInputWlascicielValid ||
                                        !isListKryptoaktywaValid) {
                                      setState(() {});
                                      return;
                                    }

                                    var task = (listKryptoaktywaKey.currentState! as ListKryptoaktywState).task();
                                    //test is any value in task is empty
                                    if (task.cryptoPairs.any((element) =>
                                        element.amount == null ||
                                        element.amount!.isEmpty ||
                                        element.inputCurrency == null ||
                                        element.inputCurrency!.isEmpty)) {
                                      isListKryptoaktywaValidPary = false;
                                      setState(() {});
                                      return;
                                    } else {
                                      isListKryptoaktywaValidPary = true;
                                      setState(() {});
                                    }

                                    step = 2;
                                    setState(() {});
                                    cryptoConversionResult = ProcessTask(task);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                    backgroundColor: blue,
                                  ),
                                  child: Text(
                                    'Zatwierdź | Następny krok',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const StepHeader(
                      top: 82.0,
                      left: 34.0 + 550.0 + 34.0,
                      text: "Krok 2/3 - Podgląd i edycja danych giełdowych",
                    ),
                    Positioned(
                      top: 114.0,
                      bottom: 34.0,
                      left: 34.0 + 550.0 + 34.0,
                      right: 34.0,
                      child: Container(
                        padding: const EdgeInsets.all(34.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black12,
                            width: 1.0,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const GenerationInfo(),
                            padding(8),
                            const TableLegend(),
                            padding(4),
                            Expanded(
                              child: SingleChildScrollView(
                                child: FutureBuilder(
                                  future: cryptoConversionResult,
                                  builder: (context, snapshot) {
                                    //switch based on null and not waiting and success
                                    if (cryptoConversionResult == null) {
                                      return Container();
                                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(
                                        child: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: CircularProgressIndicator(
                                            color: red,
                                            strokeWidth: 6,
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          if (snapshot.data != null)
                                            for (var cryptoExchangeData in snapshot.data!.cryptoConversions)
                                              TableKryptowaluta(
                                                kryptoaktywa: cryptoExchangeData.task.inputCurrency!,
                                                ilosc: cryptoExchangeData.task.amount!,
                                                data: [
                                                  for (var exchangeData in cryptoExchangeData.exchangeInfos)
                                                    TableCryptoExchangeData(
                                                      status: (exchangeData.isReached && exchangeData.isSuccess)
                                                          ? "OK"
                                                          : "FAIL",
                                                      adres: exchangeData.marketUrl,
                                                      nazwa: exchangeData.marketName,
                                                      kurs: exchangeData.exchangeRate,
                                                      waluta: exchangeData.exchangeCurrency,
                                                      wartosc: exchangeData.exchangeValue,
                                                      kursNaPLN: snapshot
                                                              .data!.plnExchange[exchangeData.exchangeCurrency]?.rate ??
                                                          "",
                                                      wartoscWPLN: exchangeData.exchangeRate,
                                                    ),
                                                ],
                                              ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            padding(8),
                            SizedBox(
                              width: double.infinity,
                              height: 50.0,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: SizedBox(
                                      height: 50.0,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          ProcessTask(
                                                  (listKryptoaktywaKey.currentState! as ListKryptoaktywState).task())
                                              .then((value) => print(value));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(1),
                                          ),
                                          backgroundColor: blue,
                                        ),
                                        child: Text(
                                          'Zatwierdź | Wygeneruj raport PDF',
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  padding(8),
                                  Expanded(
                                    child: SizedBox(
                                      height: 50.0,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            step = 1;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(1),
                                          ),
                                          backgroundColor: red,
                                        ),
                                        child: Text(
                                          'Cofnij',
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (step > 1)
                      const ApprovedBlocker(
                        top: 114.0,
                        bottom: 34.0,
                        left: 34.0,
                      ),
                    if (step < 2)
                      const LockedBlocker(
                        top: 114.0,
                        bottom: 34.0,
                        left: 34.0 + 550.0 + 34.0,
                        right: 34.0,
                      ),
                    if (step > 2)
                      const ApprovedBlocker(
                        top: 114.0,
                        bottom: 34.0,
                        left: 34.0 + 550.0 + 34.0,
                        right: 34.0,
                      ),
                    //add exit prompt

                    if (false)
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 34.0, horizontal: 22.0),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            border: Border.all(
                              color: Colors.black12,
                              width: 1.0,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(1.0),
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 500,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 1.0,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(1.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Czy na pewno chcesz wyjść?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Wszystkie niezatwierdzone dane zostaną utracone.",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 50.0,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(1),
                                              ),
                                              backgroundColor: blue,
                                            ),
                                            child: Text(
                                              'Tak',
                                              style: GoogleFonts.inter(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 50.0,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(1),
                                              ),
                                              backgroundColor: red,
                                            ),
                                            child: Text(
                                              'Nie',
                                              style: GoogleFonts.inter(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TableCryptoExchangeData {
  final String status;
  final String adres;
  final String nazwa;
  final String kurs;
  final String waluta;
  final String wartosc;
  final String kursNaPLN;
  final String wartoscWPLN;

  TableCryptoExchangeData(
      {required this.status,
      required this.adres,
      required this.nazwa,
      required this.kurs,
      required this.waluta,
      required this.wartosc,
      required this.kursNaPLN,
      required this.wartoscWPLN});
}

class TableKryptowaluta extends StatelessWidget {
  final String kryptoaktywa;
  final String ilosc;
  final List<TableCryptoExchangeData> data;
  const TableKryptowaluta({
    super.key,
    required this.kryptoaktywa,
    required this.ilosc,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 98,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(1.0),
                  ),
                ),
                child: Center(child: HeaderText(kryptoaktywa)),
              ),
            ),
            Flexible(
              flex: 97,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(1.0),
                  ),
                ),
                child: Center(child: HeaderText(ilosc)),
              ),
            ),
            Flexible(
              flex: 700,
              child: Column(
                children: [
                  for (var exchangeData in data) TableRowKonwersja(exchangeData: exchangeData),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TableRowKonwersja extends StatelessWidget {
  final TableCryptoExchangeData exchangeData;
  const TableRowKonwersja({
    super.key,
    required this.exchangeData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        children: [
          Container(
            height: 32,
            width: 24,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(1.0),
              ),
              //add color based on status
              color: exchangeData.status == "OK"
                  ? green
                  : exchangeData.status == "FAIL"
                      ? red
                      : blue,
            ),
            child: Center(
              //info icon
              child: Icon(
                //switch icon based on status
                exchangeData.status == "OK"
                    ? Icons.check_circle_outline_rounded
                    : exchangeData.status == "FAIL"
                        ? Icons.error_outline_rounded
                        // writing manual data
                        : Icons.edit_outlined,
                color: Colors.white,
                size: 16.0,
              ),
            ),
          ),
          ...exchangeData.status == "OK"
              ? [
                  TableText(exchangeData.adres, exchangeData.status),
                  TableText(exchangeData.nazwa, exchangeData.status),
                  TableText(exchangeData.kurs, exchangeData.status),
                  TableText(exchangeData.waluta, exchangeData.status),
                  ...exchangeData.waluta != "PLN"
                      ? [
                          TableText(exchangeData.wartosc, exchangeData.status),
                          TableText(exchangeData.kursNaPLN, exchangeData.status),
                          TableText(exchangeData.wartoscWPLN, exchangeData.status),
                        ]
                      : [
                          TableText("——", exchangeData.status),
                          TableText("——", exchangeData.status),
                          TableText(exchangeData.wartosc, exchangeData.status),
                        ],
                ]
              : [
                  TableText(exchangeData.adres, exchangeData.status),
                  TableText(exchangeData.nazwa, exchangeData.status),
                  TableText("——", exchangeData.status),
                  TableText("——", exchangeData.status),
                  TableText("——", exchangeData.status),
                  TableText("——", exchangeData.status),
                  TableText("——", exchangeData.status),
                ],
        ],
      ),
    );
  }
}

class TableText extends StatelessWidget {
  const TableText(
    this.data,
    this.status, {
    super.key,
  });

  final String data;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(1.0),
          ),
          //set alpha tint based on status
          color: status == "OK"
              ? green.withAlpha(20)
              : status == "FAIL"
                  ? red.withAlpha(20)
                  : Colors.white.withAlpha(0),
        ),
        child: Center(child: HeaderText(data)),
      ),
    );
  }
}

class GenerationInfo extends StatelessWidget {
  const GenerationInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 1.0,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(1.0),
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(Icons.info_outline_rounded),
          padding(8),
          const TooltipText("Data wygenerowania danych: ", fontSize: 14),
          const HeaderText("12.05.2021"),
          Expanded(child: Container()),
          //refresh icon
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.refresh,
              color: blue,
              size: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
  });

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  String? value;
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener(
      () => setState(() {
        value = myController.text;
      }),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(12),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(1),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: red,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(1),
        ),
      ),
      cursorColor: Colors.black,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9/\-\.]')),
      ],
      maxLength: 100,
      onSaved: (value) {
        setState(() {
          print(value);
          this.value = value;
        });
      },
    );
  }

  bool validate() {
    return value != null && value!.isNotEmpty;
  }
}

class StepHeader extends StatelessWidget {
  final double top;
  final double left;
  final String text;
  const StepHeader({
    super.key,
    required this.top,
    required this.left,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: GoogleFonts.inter(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}

class ApprovedBlocker extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  const ApprovedBlocker({
    Key? key,
    this.top,
    this.bottom,
    this.left,
    this.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 34.0, horizontal: 22.0),
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(
            color: Colors.black12,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(1.0),
          ),
        ),
        width: 550,
        child: Center(
          child: Icon(
            Icons.check_circle,
            color: green,
            size: 76.0,
          ),
        ),
      ),
    );
  }
}

class LockedBlocker extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  const LockedBlocker({
    Key? key,
    this.top,
    this.bottom,
    this.left,
    this.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 34.0, horizontal: 22.0),
        decoration: BoxDecoration(
          color: Colors.black54,
          border: Border.all(
            color: Colors.black12,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(1.0),
          ),
        ),
        width: 550,
        child: const Center(
          child: Icon(
            //locked icon
            Icons.lock_outline_rounded,
            color: Colors.grey,
            size: 76.0,
          ),
        ),
      ),
    );
  }
}

class Headbar extends StatefulWidget {
  const Headbar({
    super.key,
  });

  @override
  State<Headbar> createState() => _HeadbarState();
}

class _HeadbarState extends State<Headbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 42,
      decoration: BoxDecoration(color: red),
      child: Row(
        children: [
          //load logo
          padding(8),
          Image.asset(
            'assets/app_icon.png',
            width: 16,
            height: 16,
          ),
          padding(4),
          GestureDetector(
            onPanStart: ((details) {
              window.drag();
            }),
            onDoubleTap: () {
              window.toggle();
            },
            child: Text(
              "Kryptokasa.GOV",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onPanStart: ((details) {
                window.drag();
              }),
              onDoubleTap: () {
                window.toggle();
              },
              child: Container(
                color: red,
              ),
            ),
          ),
          WinBarButton(
            "🗕",
            action: () {
              window.minimize();
            },
          ),
          WinBarButton(
            window.isMaximized ? "🗖" : "🗖",
            action: () {
              window.toggle();
              setState(() {});
            },
          ),
          WinBarButton(
            "X",
            action: () {
              window.close();
            },
          ),
        ],
      ),
    );
  }
}

class WinBarButton extends StatefulWidget {
  const WinBarButton(
    this.data, {
    Key? key,
    required this.action,
  }) : super(key: key);

  final String data;
  final VoidCallback action;

  @override
  State<WinBarButton> createState() => _WinBarButtonState();
}

class _WinBarButtonState extends State<WinBarButton> {
  bool _hover = false;
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          _hover = true;
        });
      },
      onExit: (event) {
        setState(() {
          _hover = false;
          _down = false;
        });
      },
      child: Listener(
        onPointerDown: (event) {
          setState(() {
            _down = true;
          });
        },
        onPointerUp: ((event) {
          setState(() {
            _down = false;
          });
          widget.action();
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: _hover
                ? _down
                    ? const Color.fromARGB(255, 245, 216, 223)
                    : const Color.fromARGB(255, 244, 72, 112)
                : const Color.fromARGB(255, 220, 0, 50),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 1.0),
                child: Text(
                  widget.data,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget padding(double size) => SizedBox(width: size, height: size);

// ignore: non_constant_identifier_names
Padding vertical_separate() => Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6, left: 2, right: 2),
      child: Container(
        width: 1,
        color: const Color.fromARGB(255, 59, 59, 59),
      ),
    );
