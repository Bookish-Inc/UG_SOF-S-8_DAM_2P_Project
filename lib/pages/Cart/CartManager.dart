import 'package:proyecto_segundo_parcial_dam/services/BooksServices.dart';
import 'package:proyecto_segundo_parcial_dam/services/FileServices.dart';

import '../../models/Cart.dart';
import '../../models/libro.dart';

class CartManager {
  late BookServices bookServices;

  void addCart() {}

  CartManager() {
    bookServices = BookServices();
  }

  Future<List<Cart>> getList() async {
    List<dynamic> json = await FileServices.getJson('cart');
    List<Cart> lista = [];
    for (var items in json) {
      int idLibro = items['id_libro'];
      Libro? libro = await bookServices.getLibro(idLibro) ;
      lista.add(Cart(items['id'], libro!, items['cantidad']));
    }
    return lista;
  }
}
