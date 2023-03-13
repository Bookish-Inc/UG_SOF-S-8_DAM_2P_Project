import 'dart:io';
import 'package:proyecto_segundo_parcial_dam/models/usuario_favoritos.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class FavoritosServices {
  Future<List<UsuarioFavoritos>> getFavoritosFromJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    if (!(await Directory(path).exists())) {
      await Directory(path).create(recursive: true);
    }
    final file = File('$path/favoritos_usuario.json');
    final items = await file.readAsString();
    List<UsuarioFavoritos> favs = [];
    if (items.isNotEmpty) {
      final data = jsonDecode(items);
      for (var node in data) {
        favs.add(UsuarioFavoritos(
          libro_id: node["libro_id"],
          usuario_id: node["usuario_id"],
        ));
      }
    }
    return favs;
  }

  Future<File> postFavoritosToJson(int libro) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/favoritos_usuario.json');
    List<UsuarioFavoritos> favoritos = await getFavoritosFromJson();
    List<UsuarioFavoritos> favs = [];
    if (favoritos.isEmpty) {
      favs.add(UsuarioFavoritos(usuario_id: 1, libro_id: libro));
      return file.writeAsString(jsonEncode(favs));
    } else {
      favoritos.add(UsuarioFavoritos(usuario_id: 1, libro_id: libro));
      return file.writeAsString(jsonEncode(favoritos));
    }
  }

  Future<File> deleteFavoritosFromJson(int libro) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/favoritos_usuario.json');
    List<UsuarioFavoritos> favoritos = await getFavoritosFromJson();
    favoritos.removeWhere((favorito) => favorito.libro_id == libro);
    print(favoritos);
    return file.writeAsString(jsonEncode(favoritos));
  }
}
