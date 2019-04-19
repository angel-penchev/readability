import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

bool fileExists = false;
Map<String, String> fileContent;

File jsonCreate(Directory dir, String fileName) {
  File file = new File(dir.path + "/" + fileName);
  file.createSync();
  fileExists = true;
  return file;
}

void jsonWrite(File jsonFile, String key, String value) {
  Map<String, String> content = {key: value};
  Map<String, String> jsonFileContent = json.decode(jsonFile.readAsStringSync());
  jsonFileContent.addAll(content);
  jsonFile.writeAsStringSync(json.encode(jsonFileContent));
}

Map<String, String> jsonRead(File jsonFile) {
  return json.decode(jsonFile.readAsStringSync());
}
