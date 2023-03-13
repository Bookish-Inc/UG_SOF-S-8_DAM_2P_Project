import 'dart:convert';
import 'dart:io';
import 'package:proyecto_segundo_parcial_dam/models/sugerencias.dart';
import 'package:path_provider/path_provider.dart';

class SugerenciasService {
  static const _archivo = 'sugerenciass.json';

  Future<List<Sugerencia>> getSugerencias() async {
    final directorio = await getApplicationDocumentsDirectory();
    final archivo = File('${directorio.path}/$_archivo');

    if (!archivo.existsSync()) {
      return [];
    }

    final contenido = await archivo.readAsString();
    final json = jsonDecode(contenido);
    final sugerencias =
        List<Sugerencia>.from(json.map((x) => Sugerencia.fromMap(x)));
    print(sugerencias);
    return sugerencias;
  }

  Future<void> agregarSugerencia(Sugerencia sugerencia) async {
    final directorio = await getApplicationDocumentsDirectory();
    final archivo = File('${directorio.path}/$_archivo');

    final sugerencias = await getSugerencias();
    sugerencias.add(sugerencia);

    final json = jsonEncode(sugerencias.map((x) => x.toMap()).toList());
    await archivo.writeAsString(json);
    print(json);
  }

  Future<List<Map<String, dynamic>>> getSugerenciasAsMap() async {
    final directorio = await getApplicationDocumentsDirectory();
    final archivo = File('${directorio.path}/$_archivo');

    if (!archivo.existsSync()) {
      return [];
    }

    final contenido = await archivo.readAsString();
    final json = jsonDecode(contenido);

    return List<Map<String, dynamic>>.from(json);
  }

  Future<void> eliminarSugerencia(int index) async {
    final directorio = await getApplicationDocumentsDirectory();
    final archivo = File('${directorio.path}/$_archivo');

    final sugerencias = await getSugerencias();
    sugerencias.removeAt(index);

    final json = jsonEncode(sugerencias.map((x) => x.toMap()).toList());
    await archivo.writeAsString(json);
  }
}
