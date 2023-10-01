import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:kryptokasa/settings.dart' as settings;

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
  return pw.Column(
    mainAxisSize: pw.MainAxisSize.min,
    children: [
      pw.Container(
        height: 200,
        child: pw.Text(',,Szacowanie wartości kryptoaktywów”'),

      ),
      pw.Row(
        children: [
          pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text('ID raportu'),
              pw.Text('Raport z dnia'),
              pw.Text('Numer sprawy'),
              pw.Text('Dane właściciela'),
              pw.Text('Średnia wartość aktywów')
            ],
          ),
        ],
      ),

    ],
  );
}

List<pw.Widget> _buildBody(pw.Context context) {
  return [
    pw.Text('test'),
  ];
}
