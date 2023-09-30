import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color red = const Color.fromARGB(255, 255, 0, 0);
Color blue = const Color.fromARGB(255, 0, 82, 164);

class HeaderText extends StatelessWidget {
  final String data;

  const HeaderText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.left,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    );
  }
}

class TooltipText extends StatelessWidget {
  final String data;

  const TooltipText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.left,
      style: GoogleFonts.inter(
        color: Colors.black54,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
    );
  }
}
