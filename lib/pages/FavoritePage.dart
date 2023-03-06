import 'package:flutter/material.dart';
import 'package:proyecto_segundo_parcial_dam/models/libro.dart';
import 'package:proyecto_segundo_parcial_dam/models/usuario_favoritos.dart';
import 'package:proyecto_segundo_parcial_dam/services/FavoritosServices.dart';

import '../components/BookCard.dart';
import '../services/BooksServices.dart';

class FavoritePage extends StatefulWidget {
  // const FavoritePage({Key? key}) : super(key: key);
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
    final List<UsuarioFavoritos> favs =
        await favsServices.getFavoritosFromJson();
    final List<Libro> books = await bookServices.getBooksFromJson();
    List<Libro> favorites_books = [];
    if (favs.isNotEmpty) {
      for (var i = 0; i <= favs.length; i++) {
        var book = books.where((book) => book.id == favs[i].libro_id).toList();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/fondo.png'),
            fit: BoxFit.cover,
          ),
        ),
        height: 200.0,
        width: double.infinity,
        color: Colors.indigoAccent,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _favorites.length,
          itemBuilder: (context, index) {
            final Libro book = _favorites[index];
            return BookCard(
              id: book.id,
              imageUrl: book.imagen,
              title: book.titulo,
            );
          },
        ),
      ),
    );
  }
}
