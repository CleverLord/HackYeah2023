import 'dart:io';

import 'package:kryptokasa/front/dropdown_naczelnicy.dart';
import 'package:kryptokasa/main.dart';
import 'package:kryptokasa/settings.dart' as settings;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> createPdf() async {
  final doc = pw.Document();

  doc.addPage(pw.MultiPage(
    header: _buildHeader,
    build: _buildBody,
    mainAxisAlignment: pw.MainAxisAlignment.center,
    crossAxisAlignment: pw.CrossAxisAlignment.center,
  ));

  String path = '${settings.reportSavePath}example.pdf';
  print(path);
  final file = File(path);
  await file.writeAsBytes(await doc.save());
}

pw.Widget _buildHeader(pw.Context context) {
  var font = pw.Font.ttf(File('assets/Inter.ttf').readAsBytesSync().buffer.asByteData());
  return pw.Column(
    mainAxisSize: pw.MainAxisSize.min,
    children: [
      pw.Container(
        height: 200,
        child: pw.Text('Szacowanie wartości kryptoaktywów',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font, fontSize: 24)),
      ),
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black, width: 1)),
        padding: const pw.EdgeInsets.all(8),
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            pw.Row(
              children: [
                pw.Text('Numer sprawy: ', style: pw.TextStyle(fontWeight: pw.FontWeight.normal, font: font)),
                pw.Text((inputSprawaKey.currentState as CustomTextFieldState).value!,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font)),
              ],
            ),
            pw.Row(
              children: [
                pw.Text('Dane właściciela: ', style: pw.TextStyle(fontWeight: pw.FontWeight.normal, font: font)),
                pw.Text((inputWlascicielKey.currentState as CustomTextFieldState).value!,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font)),
              ],
            ),
            pw.Row(
              children: [
                pw.Text('Organ egzekujacy: ', style: pw.TextStyle(fontWeight: pw.FontWeight.normal, font: font)),
                pw.Text((dropdownNaczelnicyKey.currentState as DropdownNaczelnicyState).value!,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font)),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

List<pw.Widget> _buildBody(pw.Context context) {
  return [
    pw.Text('Brak kontunuacji :<< bo czasu brak'),
  ];
}
