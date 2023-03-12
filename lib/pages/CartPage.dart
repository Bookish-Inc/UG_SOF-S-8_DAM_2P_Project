import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

import 'Cart/Libro.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Libro> libros = [];
  @override
  void initState() {
    super.initState();
    _leerLibros();
  }

  Future<void> _leerLibros() async {
    final data =
    await DefaultAssetBundle.of(context).loadString('assets/libros.xml');

    final document = xml.parse(data);
    final elementos = document.findAllElements('libro');

    setState(() {
      libros = elementos.map((elemento) {
        final titulo = elemento.findElements('titulo').single.text;
        final autor = elemento.findElements('autor').single.text;
        final precio =
        double.parse(elemento.findElements('precio').single.text);
        return Libro(titulo: titulo, autor: autor, precio: precio);
      }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bookis - Cart",
      home: Scaffold(
        body: ListView.builder(
          itemCount: libros.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(
                    libros[index].titulo,
                    style:  const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Autor: ${libros[index].autor}'),
                      Text(
                        'Precio: \$${libros[index].precio.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
