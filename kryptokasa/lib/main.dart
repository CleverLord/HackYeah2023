import 'package:definitely_not_window/definitely_not_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kryptokasa/api/api.dart';
import 'package:kryptokasa/front/common.dart';
import 'package:kryptokasa/front/list_kryptoaktyw.dart';

import 'front/dropdown_naczelnicy.dart';

void main() {
  //ensure windowo initialised
  WidgetsFlutterBinding.ensureInitialized();

  onWindowReady(() {
    window.title = "<Title>";
    window.minSize = const Size(1000, 500);
    window.show();
  });
  runApp(const MyApp());
}

GlobalKey cryptoListKey = GlobalKey();

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
                    //add gear icon in top right corner
                    Positioned(
                      top: 34.0,
                      right: 34.0,
                      child: Icon(
                        Icons.settings,
                        color: blue,
                        size: 34.0,
                      ),
                    ),
                    Positioned(
                      top: 34.0,
                      left: 34.0,
                      child: Text(
                        "Kreator wniosku o zablokowanie kryptoaktyw w celu egzekucji",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    //Create step index text
                    Positioned(
                      top: 82.0,
                      left: 34.0,
                      child: Text(
                        "Krok 1/3 - Dane podstawowe",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 114.0,
                      bottom: 34.0,
                      left: 34.0,
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
                        width: 550, // Adjust the width as needed
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const HeaderText("Organ Egzekucyjny"),
                                    const TooltipText(
                                        "Wybierz organ egzekucyjny, który będzie egzekwował zobowiązanie"),
                                    padding(8),
                                    const DropdownNaczelnicy(),
                                    padding(12),
                                    const HeaderText("Numer Sprawy"),
                                    const TooltipText(
                                        "Podaj numer sprawy, w której organ egzekucyjny wydał decyzję o zablokowaniu kryptoaktyw"),
                                    padding(8),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.all(12),
                                        // Ustawianie border dla normalnego stanu
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black12, // Kolor border
                                            width: 1.0, // Szerokość border w normalnym stanie
                                          ),
                                          borderRadius: BorderRadius.circular(1), // Usuwanie zaokrąg
                                        ),
                                        // Ustawianie border dla stanu zaznaczenia
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black, // Kolor border w stanie zaznaczenia
                                            width: 2.0, // Szerokość border w stanie zaznaczenia
                                          ),
                                          borderRadius: BorderRadius.circular(1), // Usuwanie zaokrąg
                                        ),
                                      ),

                                      cursorColor: Colors.black, // This changes the caret color.

                                      inputFormatters: [
                                        // Allow only letters, numbers, slash, hyphen, and dot.
                                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9/\-\.]')),
                                      ],
                                      maxLength: 100,
                                    ),
                                    const HeaderText("Dane Właściciela Kryptoaktywa"),
                                    const TooltipText(
                                        "Podaj dane właściciela kryptoaktywa, którego dotyczy wniosek o zablokowanie kryptoaktyw"),
                                    padding(8),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.all(12),
                                        // Ustawianie border dla normalnego stanu
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black12, // Kolor border
                                            width: 1.0, // Szerokość border w normalnym stanie
                                          ),
                                          borderRadius: BorderRadius.circular(1), // Usuwanie zaokrąg
                                        ),
                                        // Ustawianie border dla stanu zaznaczenia
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black, // Kolor border w stanie zaznaczenia
                                            width: 2.0, // Szerokość border w stanie zaznaczenia
                                          ),
                                          borderRadius: BorderRadius.circular(1), // Usuwanie zaokrąg
                                        ),
                                      ),

                                      cursorColor: Colors.black, // This changes the caret color.

                                      inputFormatters: [
                                        // Allow only letters, numbers, slash, hyphen, and dot.
                                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9/\-\.]')),
                                      ],
                                      maxLength: 100,
                                    ),
                                    const HeaderText("Lista Kryptoaktyw"),
                                    const TooltipText("Wybierz i podaj ilość kryptoaktyw poddanych zablokowaniu"),
                                    padding(8),
                                    ListKryptoaktyw(key: cryptoListKey),
                                  ],
                                ),
                              ),
                            ),
                            padding(8),
                            SizedBox(
                              width: double.infinity,
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  ProcessTask((cryptoListKey.currentState! as ListKryptoaktywState).task())
                                      .then((value) => print(value));
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
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 82.0,
                      left: 34.0 + 550.0 + 34.0,
                      child: Text(
                        "Krok 2/3 - Edycja danych giełdowych",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
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
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const HeaderText("Organ Egzekucyjny"),
                                    const TooltipText(
                                        "Wybierz organ egzekucyjny, który będzie egzekwował zobowiązanie"),
                                    padding(8),
                                    //const DropdownNaczelnicy(),
                                    padding(12),
                                    const HeaderText("Numer Sprawy"),
                                    const TooltipText(
                                        "Podaj numer sprawy, w której organ egzekucyjny wydał decyzję o zablokowaniu kryptoaktyw"),
                                    padding(8),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.all(12),
                                        // Ustawianie border dla normalnego stanu
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black12, // Kolor border
                                            width: 1.0, // Szerokość border w normalnym stanie
                                          ),
                                          borderRadius: BorderRadius.circular(1), // Usuwanie zaokrąg
                                        ),
                                        // Ustawianie border dla stanu zaznaczenia
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black, // Kolor border w stanie zaznaczenia
                                            width: 2.0, // Szerokość border w stanie zaznaczenia
                                          ),
                                          borderRadius: BorderRadius.circular(1), // Usuwanie zaokrąg
                                        ),
                                      ),

                                      cursorColor: Colors.black, // This changes the caret color.

                                      inputFormatters: [
                                        // Allow only letters, numbers, slash, hyphen, and dot.
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z0-9/\-\.ąćęłńóśźżĄĆĘŁŃÓŚŹŻ]')),
                                      ],
                                      maxLength: 100,
                                    ),
                                    const HeaderText("Dane Właściciela Kryptoaktywa"),
                                    const TooltipText(
                                        "Podaj dane właściciela kryptoaktywa, którego dotyczy wniosek o zablokowanie kryptoaktyw"),
                                    padding(8),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.all(12),
                                        // Ustawianie border dla normalnego stanu
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black12, // Kolor border
                                            width: 1.0, // Szerokość border w normalnym stanie
                                          ),
                                          borderRadius: BorderRadius.circular(1), // Usuwanie zaokrąg
                                        ),
                                        // Ustawianie border dla stanu zaznaczenia
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black, // Kolor border w stanie zaznaczenia
                                            width: 2.0, // Szerokość border w stanie zaznaczenia
                                          ),
                                          borderRadius: BorderRadius.circular(1), // Usuwanie zaokrąg
                                        ),
                                      ),

                                      cursorColor: Colors.black, // This changes the caret color.

                                      inputFormatters: [
                                        // Allow only letters, numbers, slash, hyphen, and dot.
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z0-9/\-\.ąćęłńóśźżĄĆĘŁŃÓŚŹŻ]')),
                                      ],
                                      maxLength: 100,
                                    ),
                                    const HeaderText("Lista Kryptoaktyw"),
                                    const TooltipText("Wybierz i podaj ilość kryptoaktyw poddanych zablokowaniu"),
                                    padding(8),
                                    const ListKryptoaktyw(),
                                  ],
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
                                          ProcessTask((cryptoListKey.currentState! as ListKryptoaktywState).task())
                                              .then((value) => print(value));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(1),
                                          ),
                                          backgroundColor: blue,
                                        ),
                                        child: Text(
                                          'Zatwierdź | Wygeneruj PDF',
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
                                          ProcessTask((cryptoListKey.currentState! as ListKryptoaktywState).task())
                                              .then((value) => print(value));
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
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 24,
              decoration: BoxDecoration(
                color: red,
              ),
              child: Center(
                child: Text(
                  'C 2021 - Krypto',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
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
          padding(8),
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
            window.isMaximized ? "🗕" : "🗖",
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
