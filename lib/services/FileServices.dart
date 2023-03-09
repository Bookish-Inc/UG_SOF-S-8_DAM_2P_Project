import 'dart:io';
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
}
