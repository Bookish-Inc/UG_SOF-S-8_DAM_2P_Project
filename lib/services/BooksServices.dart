import 'package:proyecto_segundo_parcial_dam/models/categorias_libros.dart';
import 'package:proyecto_segundo_parcial_dam/models/libro.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../models/categorias.dart';

class BookServices {
  Future<List<Libro>> getBooksFromJson() async {
    final String jsonString =
    await rootBundle.loadString('assets/data/libros.json');
    final items = jsonDecode(jsonString);
    // final items = document.findAllElements('libros');

    List<Libro> books = [];
    for (var node in items) {
      books.add(Libro(
        id: node["id"],
        titulo: node["titulo"],
        imagen: node["imagen"],
        descripcion: node["descripcion"],
        precio: node["precio"],
        autor: node["autor"],
        numPaginas: node["numPaginas"],
        fechaPublicacion: node["fechaPublicacion"],
        cantidad: node["cantidad"],
        estado: node["estado"] == 'true',
      ));
    }
    print(books);
    return books;
  }

  Future<Libro?> getLibro(int id) async {
    final String jsonString =
    await rootBundle.loadString('assets/data/libros.json');
    final items = jsonDecode(jsonString);
    // final items = document.findAllElements('libros');

    for (var node in items) {
      if (node["id"] != id) {
        continue;
      }
       return Libro(
        id: node["id"],
        titulo: node["titulo"],
        imagen: node["imagen"],
        descripcion: node["descripcion"],
        precio: node["precio"],
        autor: node["autor"],
        numPaginas: node["numPaginas"],
        fechaPublicacion: node["fechaPublicacion"],
        cantidad: node["cantidad"],
        estado: node["estado"] == 'true',
      );
    }
    return null;
  }

  Future<List<Categorias>> getCategoriesFromJson() async {
    final String jsonString =
    await rootBundle.loadString('assets/data/categorias.json');
    final items = jsonDecode(jsonString);
    // final items = document.findAllElements('libros');

    List<Categorias> categories = [];
    for (var node in items) {
      categories.add(Categorias(
        id: node["id"],
        nombre: node["nombre"],
        imagen: node["imagen"],
        estado: node["estado"] == 'true',
      ));
    }
    print(categories);
    return categories;
  }

  Future<List<CategoriasLibros>> getBookCategorieFromJson() async {
    final String jsonString =
    await rootBundle.loadString('assets/data/categorias_libros.json');
    final items = jsonDecode(jsonString);
    // final items = document.findAllElements('libros');

    List<CategoriasLibros> categoriesbooks = [];
    for (var node in items) {
      categoriesbooks.add(CategoriasLibros(
        libro_id: node["libro_id"],
        categoria_id: node["categoria_id"],
      ));
    }
    print(categoriesbooks);
    return categoriesbooks;
  }
}
