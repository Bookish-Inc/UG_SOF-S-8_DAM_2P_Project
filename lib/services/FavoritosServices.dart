import 'package:flutter/services.dart' show rootBundle;
import 'package:proyecto_segundo_parcial_dam/models/usuario_favoritos.dart';
import 'dart:convert';

class FavoritosServices {
  Future<List<UsuarioFavoritos>> getFavoritosFromJson() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/favoritos_usuario.json');
    final items = jsonDecode(jsonString);
    // final items = document.findAllElements('libros');

    List<UsuarioFavoritos> favs = [];
    for (var node in items) {
      favs.add(UsuarioFavoritos(
        libro_id: node["libro_id"],
        usuario_id: node["usuario_id"],
      ));
    }
    print(favs);
    return favs;
  }
}
