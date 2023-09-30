import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color red = const Color.fromARGB(255, 255, 0, 0);

Text tooltipText(String data) {
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

Text headerText(String data) {
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
