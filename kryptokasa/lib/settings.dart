import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

String reportSavePath = "";
String logsSavePath = "";

late SharedPreferences prefs;

Future<void> initSettings () async{
   prefs = await SharedPreferences.getInstance();

   String? repPath = prefs.getString('reports');
   String? logPath = prefs.getString('logs');

   if (repPath == null || logPath == null) {
     Directory appDocDir = await getApplicationDocumentsDirectory();
     String appDocPath = appDocDir.path;

     if (!appDocPath.endsWith('\\')) {
       if (!appDocPath.endsWith('/')) {
         appDocPath += '\\';
       }
     }

     repPath ??= '${appDocPath}Raporty Kryptowalut\\';
     logPath ??= '${appDocPath}Logi kryptowalut\\';
   }
}

Future<String> editReportPath () async{
  final path = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Wybierz folder do zapisywania raportów', lockParentWindow: true, initialDirectory: reportSavePath);

  if (path == null) {
    return reportSavePath;
  }

  reportSavePath = path;

  return path;
}

Future<String> editLogsPath () async{
  final path = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Wybierz folder do zapisywania logów', lockParentWindow: true, initialDirectory: reportSavePath);

  if (path == null) {
    return logsSavePath;
  }

  logsSavePath = path;

  return path;
}