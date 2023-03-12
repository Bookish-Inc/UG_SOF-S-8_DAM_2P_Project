// ignore_for_file: non_constant_identifier_names

class UsuarioFavoritos {
  final int libro_id;
  final int usuario_id;
  UsuarioFavoritos({required this.usuario_id, required this.libro_id});

  UsuarioFavoritos.fromJson(Map<String, dynamic> json)
      : libro_id = json['libro_id'],
        usuario_id = json['usuario_id'];

  Map<String, dynamic> toJson() {
    return {
      'libro_id': libro_id,
      'usuario_id': usuario_id,
    };
  }
}
