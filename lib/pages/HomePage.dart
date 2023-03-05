import 'package:flutter/material.dart';
import '../models/categorias.dart';
import '../services/BooksServices.dart';

import '../components/BookCard.dart';
import '../models/libro.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _State();
}

class _State extends State<HomePage> {
  late List<Libro> _books = [];
  late List<Categorias> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
    _loadCategories();
  }

  Future<void> _loadBooks() async {
    final BookServices bookServices = BookServices();
    final List<Libro> books = await bookServices.getBooksFromJson();

    setState(() {
      _books = books;
    });
  }

  Future<void> _loadCategories() async {
    final BookServices bookServices = BookServices();
    final List<Categorias> categories =
        await bookServices.getCategoriesFromJson();

    setState(() {
      _categories = categories;
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
        child: _books == null
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  // Primera fila con texto 'Bienvenido'
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      'Bienvenido',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Segunda fila con imagen que ocupa todo el ancho de la pantalla
                  Container(
                    width: double.infinity,
                    child: const Image(
                      image: AssetImage('assets/images/banner.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 8.0),
                  // Tercera fila con texto 'Recomendaciones' y ListView horizontal de libros
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Recomendaciones',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  ),

                  Container(
                    height: 200.0,
                    width: double.infinity,
                    color: Colors.indigoAccent,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _books.length,
                      itemBuilder: (context, index) {
                        final Libro book = _books[index];
                        return BookCard(
                          imageUrl: book.imagen,
                          title: book.titulo,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 8.0),
                  // Tercera fila con texto 'Recomendaciones' y ListView horizontal de libros
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Categorías',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  ),

                  Container(
                    height: 200.0,
                    width: double.infinity,
                    color: Colors.lightBlueAccent,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final Categorias categorie = _categories[index];
                        return BookCard(
                          imageUrl: categorie.imagen,
                          title: categorie.nombre,
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
