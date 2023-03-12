import 'package:flutter/material.dart';
import 'package:proyecto_segundo_parcial_dam/components/StarRadioButton.dart';
import 'package:proyecto_segundo_parcial_dam/models/categorias_libros.dart';

import '../models/categorias.dart';
import '../models/libro.dart';
import '../models/usuario_favoritos.dart';
import '../services/BooksServices.dart';
import '../services/FavoritosServices.dart';

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
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _loadBook();
    _loadFavorito();
  }

  void _handleSelection(bool? value) {
    print(value);
    if (value == false) {
      _deleteFavorito();
    } else {
      _postFavorito();
    }

    setState(() {
      _isSelected = value ?? false;
    });
  }

  Future<void> _postFavorito() async {
    final FavoritosServices favsServices = FavoritosServices();
    await favsServices.postFavoritosToJson(_book.id);
  }

  Future<void> _deleteFavorito() async {
    final FavoritosServices favsServices = FavoritosServices();
    await favsServices.deleteFavoritosFromJson(_book.id);
  }

  Future<void> _loadFavorito() async {
    final FavoritosServices favsServices = FavoritosServices();
    final List<UsuarioFavoritos> favs =
        await favsServices.getFavoritosFromJson();
    var isFav = favs.where((e) => e.libro_id == _book.id).toList();
    bool flag = isFav.isNotEmpty ? true : false;

    setState(() {
      _isSelected = flag;
    });
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
      _isSelected = false;
    });
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
        child: _book == null
            ? const Center(child: CircularProgressIndicator())
            : ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StarRadioButton(
                        isSelected: _isSelected,
                        onSelect: _handleSelection,
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
                        maxLines: null, // allow for unlimited lines of text
                        controller: TextEditingController(
                          text: _book.descripcion,
                        ),
                        enabled: false,
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
                          Expanded(
                            child: Container(
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
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Container(
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
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
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Container(
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
