import 'package:flutter/material.dart';
import 'package:proyecto_segundo_parcial_dam/models/categorias_libros.dart';

import '../models/categorias.dart';
import '../models/libro.dart';
import '../services/BooksServices.dart';

class BookDetailPage extends StatefulWidget {
  final int id;

  // const BookDetailPage({Key? key}) : super(key: key);
  const BookDetailPage({required this.id});
  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late Libro _book;
  late String _categorie;
  @override
  void initState() {
    super.initState();
    _loadBook();
  }

  Future<void> _loadBook() async {
    final BookServices bookServices = BookServices();
    final List<Libro> books = await bookServices.getBooksFromJson();
    final List<Categorias> categories =
        await bookServices.getCategoriesFromJson();
    final List<CategoriasLibros> categoriesbooks =
        await bookServices.getBookCategorieFromJson();
    var categbooks =
        categoriesbooks.where((cb) => cb.libro_id == widget.id).toList();
    var categorias = [];
    for (var item1 in categbooks) {
      for (var item2 in categories) {
        if (item1.categoria_id == item2.id) {
          categorias.add(item2.nombre);
        }
      }
    }
    Libro detailbook =
        books.where((book) => book.id == widget.id).toList().first;
    var categoriasString = categorias.join(';');
    setState(() {
      _book = detailbook;
      _categorie = categoriasString;
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
        child: _book == null
            ? Center(child: CircularProgressIndicator())
            : ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.star),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  width: 150,
                  height: 250,
                  child: Image.network(
                    _book.imagen,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    height: 160,
                    child: SingleChildScrollView(
                      child: TextField(
                        maxLines: 7, // allow for unlimited lines of text
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Enter your text here',
                        ),
                        controller: TextEditingController(
                          text: _book.descripcion,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              _book.fechaPublicacion,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              _categorie,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              _book.autor,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              _book.precio.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text('Agregar a Carrito'),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
      ),
    );
  }
}
