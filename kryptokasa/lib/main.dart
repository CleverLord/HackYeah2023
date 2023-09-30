import 'package:definitely_not_window/definitely_not_window.dart';
import 'package:flutter/material.dart';

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 32,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 234, 57, 75),
//round bottom border to match top
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 6.0,
                  right: 6.0,
                  bottom: 6.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onPanStart: ((details) {
                          window.drag();
                        }),
                        onDoubleTap: () {
                          window.toggle();
                        },
                        child: const Center(
                          child: Text(
                            "[Drag me / Double click me]",
                          ),
                        ),
                      ),
                    ),
                    WinBarButton(
                      "Minimize",
                      action: () {
                        window.minimize();
                      },
                    ),
                    padding(5),
                    WinBarButton(
                      window.isMaximized ? "Restore" : "Maximize",
                      action: () {
                        window.toggle();
                        setState(() {});
                      },
                    ),
                    padding(5),
                    WinBarButton(
                      "X",
                      action: () {
                        window.close();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: const Center(
                  child: Text(
                    "Definitely Not Window",
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
          width: null,
          height: double.infinity,
          decoration: BoxDecoration(
            color: _hover
                ? _down
                    ? const Color.fromARGB(255, 80, 80, 80)
                    : const Color.fromARGB(255, 59, 59, 59)
                : const Color.fromARGB(255, 44, 44, 44),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: const Color.fromARGB(255, 59, 59, 59),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 1.0),
                child: Text(
                  widget.data,
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
