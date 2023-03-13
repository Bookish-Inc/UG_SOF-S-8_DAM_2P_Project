import 'package:flutter/scheduler.dart';

class Sugerencia {
  late String titulo;
  late String edicion;
  late String editorial;
  late String fechaPublicacion;
  late String nombresAutorLibro;
  late String comentarios;

  Sugerencia(
      {required this.titulo,
      required this.edicion,
      required this.editorial,
      required this.fechaPublicacion,
      required this.nombresAutorLibro,
      required this.comentarios}) {}

  // Convertir los datos a un mapa para guardarlos en un archivo JSON
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'edicion': edicion,
      'editorial': editorial,
      'fechaPublicacion': fechaPublicacion,
      'nombresAutorLibro': nombresAutorLibro,
      'comentarios': comentarios
    };
  }

  factory Sugerencia.fromMap(Map<String, dynamic> map) {
    return Sugerencia(
        titulo: map['titulo'],
        edicion: map['edicion'],
        editorial: map['editorial'],
        fechaPublicacion: map['fechaPublicacion'],
        nombresAutorLibro: map['nombresAutorLibro'],
        comentarios: map['comentarios']);
  }
}
