import 'package:flutter/material.dart';
import 'package:proyecto_segundo_parcial_dam/models/categorias.dart';
import 'package:proyecto_segundo_parcial_dam/models/categorias_libros.dart';
import 'package:proyecto_segundo_parcial_dam/models/libro.dart';
import 'package:proyecto_segundo_parcial_dam/models/usuario_favoritos.dart';
import 'package:proyecto_segundo_parcial_dam/services/FavoritosServices.dart';

import '../components/BookCard.dart';
import '../services/BooksServices.dart';

class FavoritePage extends StatefulWidget {
  final int categoria;

  const FavoritePage({required this.categoria});
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late List<Libro> _favorites = [];
  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final FavoritosServices favsServices = FavoritosServices();
    final BookServices bookServices = BookServices();
    List<Libro> favorites_books = [];
    if (widget.categoria == 0) {
      final List<UsuarioFavoritos> favs =
          await favsServices.getFavoritosFromJson();
      final List<Libro> books = await bookServices.getBooksFromJson();
      if (favs.isNotEmpty) {
        for (var i = 0; i <= favs.length - 1; i++) {
          var book =
              books.where((book) => book.id == favs[i].libro_id).toList();
          favorites_books.add(Libro(
              id: book.first.id,
              titulo: book.first.titulo,
              imagen: book.first.imagen,
              descripcion: book.first.descripcion,
              precio: book.first.precio,
              autor: book.first.autor,
              numPaginas: book.first.numPaginas,
              fechaPublicacion: book.first.fechaPublicacion,
              cantidad: book.first.cantidad,
              estado: book.first.estado));
        }
      }
      setState(() {
        _favorites = favorites_books;
      });
    } else {
      final List<Libro> books = await bookServices.getBooksFromJson();
      final List<CategoriasLibros> bookcateg =
          await bookServices.getBookCategorieFromJson();
      var booksCateg = bookcateg
          .where((book) => book.categoria_id == widget.categoria)
          .toList();
      for (var i = 0; i <= booksCateg.length - 1; i++) {
        var booksNuevos =
            books.where((book) => book.id == booksCateg[i].libro_id).toList();
        favorites_books.add(Libro(
            id: booksNuevos.first.id,
            titulo: booksNuevos.first.titulo,
            imagen: booksNuevos.first.imagen,
            descripcion: booksNuevos.first.descripcion,
            precio: booksNuevos.first.precio,
            autor: booksNuevos.first.autor,
            numPaginas: booksNuevos.first.numPaginas,
            fechaPublicacion: booksNuevos.first.fechaPublicacion,
            cantidad: booksNuevos.first.cantidad,
            estado: booksNuevos.first.estado));
      }
      setState(() {
        _favorites = favorites_books;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Container(
              height: 200.0,
              child: Wrap(
                children: _favorites.chunked(3).map((chunk) {
                  return Container(
                    height: 200.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: chunk.length,
                      itemBuilder: (context, index) {
                        final Libro book = chunk[index];
                        return BookCard(
                          id: book.id,
                          imageUrl: book.imagen,
                          title: book.titulo,
                          categoria: 0,
                          isBookshelf: false,
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension ListChunkExtension<T> on List<T> {
  List<List<T>> chunked(int chunkSize) {
    final List<List<T>> chunks = [];
    for (var i = 0; i < length; i += chunkSize) {
      final end = (i + chunkSize < length) ? i + chunkSize : this.length;
      chunks.add(this.sublist(i, end));
    }
    return chunks;
  }
}
