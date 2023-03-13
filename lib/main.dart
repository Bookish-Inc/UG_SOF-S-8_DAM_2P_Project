import 'package:flutter/material.dart';
import 'package:proyecto_segundo_parcial_dam/pages/AccountPage.dart';
import 'package:proyecto_segundo_parcial_dam/pages/BookDetailPage.dart';
import 'package:proyecto_segundo_parcial_dam/pages/CartPage.dart';
import 'package:proyecto_segundo_parcial_dam/pages/FavoritePage.dart';
import 'package:proyecto_segundo_parcial_dam/pages/HomePage.dart';
import 'package:proyecto_segundo_parcial_dam/pages/ListaSugerenciasPages.dart';
import 'package:proyecto_segundo_parcial_dam/pages/SuggestPage.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  List<Widget> pages = [
    HomePage(),
    const CartPage(),
    const SuggestPage(),
    const FavoritePage(categoria: 0),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bookish",
      home: Scaffold(
        body: pages[_currentPage],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          currentIndex: _currentPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.lightbulb), label: "Sugerencia"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Fav"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: "Cuenta"),
          ],
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
