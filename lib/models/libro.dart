class Libro {
  final int id;
  final String titulo;
  final String imagen;
  final String descripcion;
  final double precio;
  final String autor;
  final int numPaginas;
  final String fechaPublicacion;
  final int cantidad;
  final bool estado;

  Libro({
    required this.id,
    required this.titulo,
    required this.imagen,
    required this.descripcion,
    required this.precio,
    required this.autor,
    required this.numPaginas,
    required this.fechaPublicacion,
    required this.cantidad,
    required this.estado,
  });
}
