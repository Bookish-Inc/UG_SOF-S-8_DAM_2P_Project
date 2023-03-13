import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:convert';
import 'dart:io';
import 'package:proyecto_segundo_parcial_dam/models/sugerencias.dart';
import 'package:proyecto_segundo_parcial_dam/pages/ListaSugerenciasPages.dart';
import 'package:proyecto_segundo_parcial_dam/services/SugerenciasService.dart';
import 'package:intl/intl.dart';

class SuggestPage extends StatefulWidget {
  const SuggestPage({Key? key}) : super(key: key);

  @override
  State<SuggestPage> createState() => _SuggestPageState();
}

class _SuggestPageState extends State<SuggestPage> {
  final _formKey = GlobalKey<FormState>();

  final _tituloController = TextEditingController();
  final _edicicionController = TextEditingController();
  final _editorialController = TextEditingController();
  final _publishDateController = TextEditingController();
  final _nombresAutorController = TextEditingController();
  final _comentariosController = TextEditingController();

  /*final _sugerencia = Sugerencia(
      titulo: '',
      edicion: '',
      editorial: '',
      fechaPublicacion: '',
      nombresAutorLibro: '',
      comentarios: '');*/

  final _sugerenciasService = SugerenciasService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              color: Color.fromARGB(255, 57, 76, 188),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Text(
                      "Sugerencias",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 123, 136, 209),
                            Colors.indigo,
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //titulo
                          TextFormField(
                            controller: _tituloController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Titulo',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: Validator.alphanumeric,
                          ),
                          SizedBox(height: 16),
                          //edicion
                          TextFormField(
                            controller: _edicicionController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Edición',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: Validator.alphanumeric,
                          ),
                          SizedBox(height: 16),
                          //editorial
                          TextFormField(
                            controller: _editorialController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Editorial',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: Validator.alphanumeric,
                          ),
                          SizedBox(height: 16),
                          //fecha
                          TextFormField(
                              controller: _publishDateController,
                              style: TextStyle(color: Colors.white),
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Fecha',
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'Selecciona una fecha',
                              ),
                              onTap: () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                );
                                _publishDateController.text =
                                    formatDate(selectedDate!);
                              },
                              validator: Validator.fecha),
                          SizedBox(height: 16),
                          //nombres
                          TextFormField(
                            controller: _nombresAutorController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Nombres Autor',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: Validator.alfabetico,
                          ),
                          SizedBox(height: 16),
                          //comentarios
                          TextFormField(
                            controller: _comentariosController,
                            style: TextStyle(color: Colors.white),
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: 'Comentarios',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: Validator.alphanumeric,
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceAround, // Separar los elementos equitativamente
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 121, 121,
                                        169), // Establece el color del botón
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ListaSugerenciasPage()),
                                    );
                                  },
                                  child: Text('Ver Sugerencias'),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 116, 116,
                                        208), // Establece el color del botón
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _guardarContacto(
                                          _tituloController.text,
                                          _edicicionController.text,
                                          _editorialController.text,
                                          _publishDateController.text,
                                          _nombresAutorController.text,
                                          _comentariosController.text);
                                    }
                                  },
                                  child: Text('Enviar'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  void _guardarContacto(String titulo, String edicion, String editorial,
      String fecha, String nombres, String comentarios) async {
    final _sugerencia = Sugerencia(
        titulo: titulo,
        edicion: edicion,
        editorial: editorial,
        fechaPublicacion: fecha,
        nombresAutorLibro: nombres,
        comentarios: comentarios);
    print(_sugerencia.comentarios);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _sugerenciasService.agregarSugerencia(_sugerencia);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sugerencia guardada')));
      _formKey.currentState!.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Formulario enviado')),
      );
    }
  }
}

String formatDate(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}
/*Widget MyForm(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final _numericController = TextEditingController();
  final _emailController = TextEditingController();
  final _alphanumericController = TextEditingController();


  return Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: _numericController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Número',
          ),
          validator: Validator.numeric,
        ),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Correo electrónico',
          ),
          validator: Validator.email,
        ),
        TextFormField(
          controller: _alphanumericController,
          decoration: InputDecoration(
            labelText: 'Alfanumérico',
          ),
          validator: Validator.alphanumeric,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Formulario enviado')),
                );
                //_guardarDatos();
              }
            },
            child: Text('Enviar'),
          ),
        ),
      ],
    ),
  );
}*/

class Validator {
  static String? numeric(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    final number = int.tryParse(value);
    if (number == null) {
      return 'Este campo debe ser un número';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    if (!EmailValidator.validate(value)) {
      return 'El correo electrónico no es válido';
    }
    return null;
  }

  static String? alphanumeric(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
    if (!validCharacters.hasMatch(value)) {
      return 'Este campo solo admite caracteres alfanuméricos';
    }
    return null;
  }

  static String? fecha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }

  static String? alfabetico(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    final validCharacters = RegExp(r'^[a-zA-Z]+$');
    if (!validCharacters.hasMatch(value)) {
      return 'Este campo solo admite letras';
    }
    return null;
  }
}
