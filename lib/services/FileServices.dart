import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FileServices {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFileFavoritos async {
    final path = await _localPath;
    return File('$path/favoritos_usuario.json');
  }

  static Future<List<dynamic>> getJson(String json) async {
    final String jsonString = await rootBundle.loadString('assets/data/$json.json');
    return jsonDecode(jsonString);
  }
}
