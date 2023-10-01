import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kryptokasa/main.dart';

Color red = const Color.fromARGB(255, 220, 0, 50);
Color blue = const Color.fromARGB(255, 0, 82, 164);
Color green = const Color.fromARGB(255, 0, 160, 50);

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
  final double fontSize;

  const TooltipText(this.data, {super.key, this.fontSize = 12.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.left,
      style: GoogleFonts.inter(
        color: Colors.black54,
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
      ),
    );
  }
}

class ErrorText extends StatelessWidget {
  final String data;

  const ErrorText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.error_outline,
          color: red,
          size: 12,
        ),
        padding(4),
        Text(
          data,
          textAlign: TextAlign.left,
          style: GoogleFonts.inter(
            color: red,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
