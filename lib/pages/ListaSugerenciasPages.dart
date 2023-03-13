import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_segundo_parcial_dam/models/sugerencias.dart';
import 'package:proyecto_segundo_parcial_dam/services/SugerenciasService.dart';

class ListaSugerenciasPage extends StatefulWidget {
  const ListaSugerenciasPage({super.key});

  @override
  State<ListaSugerenciasPage> createState() => _ListaSugerenciasPageState();
}

class _ListaSugerenciasPageState extends State<ListaSugerenciasPage> {
  List<Sugerencia> sugerencias = [];

  @override
  void initState() {
    super.initState();
    cargarSugerencias();
  }

  Future<void> cargarSugerencias() async {
    final sugerenciasService = SugerenciasService();
    sugerencias = await sugerenciasService.getSugerencias();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _sugerenciasService = SugerenciasService();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text('Ver Sugerencias'),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _sugerenciasService.getSugerenciasAsMap(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final sugerencias =
                  snapshot.data!.map((s) => Sugerencia.fromMap(s)).toList();

              return ListView.builder(
                itemCount: sugerencias.length,
                itemBuilder: (context, index) {
                  final sugerencia = sugerencias[index];

                  //return Card(
                  return ListTile(
                    title: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sugerencia.titulo,
                            style: TextStyle(
                              fontSize: 20.0, // Tamaño del texto
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(sugerencia.editorial),
                          Text(sugerencia.fechaPublicacion),
                          Text(sugerencia.nombresAutorLibro),
                        ],
                      ),
                    ),
                    //title: Text(sugerencia.titulo),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await _sugerenciasService.eliminarSugerencia(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sugerencia eliminada.'),
                          ),
                        );
                        cargarSugerencias();
                      },
                    ),
                  );
                  //);
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
