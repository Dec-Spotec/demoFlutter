import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Store {
  static saveFile(String name, String contents) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File(appDocPath + "/$name");
    await file.writeAsString(contents);
  }

  static Future<String> readFile(String name) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File(appDocPath + "/$name");
    return file.readAsString();
  }
}
