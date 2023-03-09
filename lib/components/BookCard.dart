import 'package:flutter/material.dart';
import 'package:proyecto_segundo_parcial_dam/pages/BookDetailPage.dart';
import 'package:proyecto_segundo_parcial_dam/pages/FavoritePage.dart';

class BookCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;
  final int categoria;
  final bool isBookshelf;

  const BookCard({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.categoria,
    required this.isBookshelf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                isBookshelf ? FavoritePage(categoria: categoria) : BookDetailPage(id: id),
          ),
        );
      },
      child: Container(
        width: 135.0,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
