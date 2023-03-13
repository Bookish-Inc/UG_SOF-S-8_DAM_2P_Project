import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import 'HomePage.dart';
import 'widgets/ButtonLogIn.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final user = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    user.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
          Color.fromARGB(255, 144, 154, 211),
          Color.fromARGB(255, 81, 98, 195)
        ], begin: Alignment.topCenter)),
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 100.0,
          ),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //imagen
                const CircleAvatar(
                  radius: 110.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage:
                      AssetImage('assets/images/bookish_transparente.png'),
                ),

                //Titulo del form
                const Text(
                  'Log In',
                  style: TextStyle(
                      fontFamily: 'FredokaOne',
                      fontSize: 40.0,
                      color: Colors.white),
                ),

                //espacio?
                const SizedBox(
                  height: 30.0,
                ),

                //Campos del formulario
                const Text(
                  'Nombre de usuario',
                  style: TextStyle(
                      fontFamily: 'FredokaOne',
                      fontSize: 20.0,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),

                //* Filed - Username
                TextField(
                  controller: user,
                  enableInteractiveSelection:
                      false, //desactivar interactividad por defecto
                  autofocus: true, //activar focus por defecto
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(fontFamily: 'Fresca'),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: const Icon(Icons.person),
                      hintText: 'Usuario',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  /*onSubmitted: (value) {
                      user = value;
                    }*/
                ),

                const SizedBox(
                  height: 15.0,
                ),

                const Text(
                  'Contraseña',
                  style: TextStyle(
                      fontFamily: 'FredokaOne',
                      fontSize: 20.0,
                      color: Colors.white),
                ),

                //* Field - Password
                TextField(
                  controller: password,
                  enableInteractiveSelection:
                      false, //desactivar interactividad por defecto
                  autofocus: true, //activar focus por defecto
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(fontFamily: 'Fresca'),
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: const Icon(Icons.password),
                      hintText: 'Contraseña',
                      //labelText: 'Contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                  /*onSubmitted: (value) {
                     password = value;
                    }*/
                ),
                const SizedBox(
                  height: 40.0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //* Btn Aceptar *//
                    ButtonLogIn(
                      text: "Aceptar",
                      textColor: Colors.white,
                      buttonColor: Colors.indigo,
                      onPressed: () {
                        print(
                            'El usuario es ${user.text} y la contraseña es ${password.text}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage()),
                        );
                      },
                    ),

                    //* Btn Salir */
                    ButtonLogIn(
                      text: "Salir",
                      textColor: Colors.indigo,
                      buttonColor: Colors.white,
                      onPressed: () {
                        print('Ud. ha salido del sistema');
                        SystemNavigator.pop();
                      },
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
