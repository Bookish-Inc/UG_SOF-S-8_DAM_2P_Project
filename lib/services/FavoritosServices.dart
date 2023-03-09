import 'dart:io';
import 'package:proyecto_segundo_parcial_dam/models/usuario_favoritos.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class FavoritosServices {
  Future<List<UsuarioFavoritos>> getFavoritosFromJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/favoritos_usuario.json');
    final items = await file.readAsString();
    final data = jsonDecode(items);
    List<UsuarioFavoritos> favs = [];
    for (var node in data) {
      favs.add(UsuarioFavoritos(
        libro_id: node["libro_id"],
        usuario_id: node["usuario_id"],
      ));
    }
    print(favs);
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
    favoritos.remove(UsuarioFavoritos(usuario_id: 1, libro_id: libro));
    return file.writeAsString(jsonEncode(favoritos));
  }
}
