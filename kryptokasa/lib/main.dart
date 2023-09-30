import 'package:definitely_not_window/definitely_not_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kryptokasa/CryptoList.dart';

import 'NaczelnicyUrzedowSkarbowych_Dropdown.dart';

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
                    //Create a header text
                    Positioned(
                      top: 34.0,
                      left: 34.0,
                      child: Text(
                        "Wniosek o zablokowanie kryptoaktyw w celu egzekucji",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 160.0,
                      bottom: 34.0,
                      left: 34.0,
                      child: Container(
                        padding: const EdgeInsets.all(34.0),
//drop fancy shadow
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
                        width: 600, // Adjust the width as needed
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Organ Egzekucyjny",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Wybierz organ egzekucyjny, który będzie egzekwował zobowiązanie",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            const NaczelnicyUrzedowSkarbowych_Dropdown(),
                            padding(12),
                            Text(
                              "Numer Sprawy",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Podaj numer sprawy, w której organ egzekucyjny wydał decyzję o zablokowaniu kryptoaktyw",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black), // This changes the focus color.
                                ),
                              ),

                              cursorColor: Colors.black, // This changes the caret color.

                              inputFormatters: [
                                // Allow only letters, numbers, slash, hyphen, and dot.
                                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9/\-\.]')),
                              ],
                              maxLength: 100,
                            ),
                            Text(
                              "Dane właściciela kryptoaktywa",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Podaj dane właściciela kryptoaktywa, którego dotyczy wniosek o zablokowanie kryptoaktyw",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black), // This changes the focus color.
                                ),
                              ),

                              cursorColor: Colors.black, // This changes the caret color.

                              inputFormatters: [
                                // Allow only letters, numbers, slash, hyphen, and dot.
                                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9/\-\.]')),
                              ],
                              maxLength: 100,
                            ),
                            Text(
                              "Lista Kryptoaktyw",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Wybierz i podaj ilość kryptoaktyw poddanych zablokowaniu",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            padding(8),
                            const CryptoList(),
                            Expanded(child: Container()),
                            SizedBox(
                              width: double.infinity, // Makes the button stretch horizontally
                              height: 50.0, // Sets the height of the button
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle the button press here
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 82, 164), // Set the background color to blue
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
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 24,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 220, 0, 50),
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
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 220, 0, 50),
      ),
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
                color: const Color.fromARGB(255, 220, 0, 50),
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
