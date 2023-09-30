import 'package:definitely_not_window/definitely_not_window.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    Positioned(
                      top: 10.0,
                      bottom: 10.0,
                      left: 10.0,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        width: 300, // Adjust the width as needed
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black12,
                            width: 1.0,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Nazwa organu egzekucyjnego',
                                ),
                                maxLength: 100, // limit znaków do 100
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Numer sprawy',
                                ),
                                maxLength: 100,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Dane identyfikujące właściciela kryptoaktywa',
                                ),
                                maxLength: 100,
                              ),
                              DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Nazwa kryptoaktywa',
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Bitcoin',
                                    child: Text('Bitcoin'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Ethereum',
                                    child: Text('Ethereum'),
                                  ),
                                  // dodaj inne opcje według potrzeb
                                ],
                                onChanged: (value) {
                                  // zaktualizuj stan na wybraną wartość
                                },
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Ilości kryptoaktywów',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              // Dodaj więcej pól według potrzeb
                            ],
                          ),
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
          Text(
            "Kryptokasa.GOV",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Expanded(child: Container()),
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
