import 'package:flutter/material.dart';
import 'package:proyecto_segundo_parcial_dam/pages/Cart/CartManager.dart';

import '../models/Cart.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> libros = [];
  late CartManager cartManager = CartManager();

  @override
  void initState() {
    super.initState();

      loadcarts();

  }

  Future<void> loadcarts() async {
    final List<Cart> lir = await cartManager.getList();
    setState(() {
      libros = lir;
    });

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bookis - Cart",
      home: Scaffold(
        body: ListView.builder(
          itemCount: libros.length ,
          itemBuilder: (context, index) {
            return itemCard(index);
          },
        ),
      ),
    );
  }

  Widget itemCard(int index) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7.0),
          alignment: Alignment.centerLeft,
          width: 125,
          height: 180,
          child: Image.network(
              libros[index].libro.imagen,
              fit: BoxFit.contain),
        ),
        Expanded(
          child: SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 20,
                    alignment: Alignment.topLeft,
                    child:  Text(
                      libros[index].libro.titulo,
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                const Padding(padding: EdgeInsets.only(top: 50.0)),
                Text(
                  '\$${libros[index].libro.precio * libros[index].cantidad}',
                  style: const TextStyle(
                      height: 1, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            libros[index].cantidad = libros[index].cantidad + 1;
                          });

                        },
                        icon: const Icon(
                          Icons.add_circle_rounded,
                          color: Colors.blueAccent,
                          size: 40,
                        )),
                    Text(
                      "${libros[index].cantidad}",
                      style: const TextStyle( fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                        onPressed: () {
                          if(libros[index].cantidad <= 1){
                            return;
                          }
                          setState(() {

                            libros[index].cantidad = libros[index].cantidad - 1;
                          });

                        },
                        icon: const Icon(
                          Icons.remove_circle_rounded,
                          color: Colors.blueAccent,
                          size: 40,
                        )),
                  ],
                ))
              ],
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 20.0)),
        IconButton(
            onPressed: () {
              setState(() {
                libros.removeAt(index);
              });
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 35,
            ))
      ],
    );
  }
}
