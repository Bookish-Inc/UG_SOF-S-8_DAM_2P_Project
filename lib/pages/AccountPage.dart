import 'package:flutter/material.dart';

import 'LogInPage.dart';
import 'widgets/ButtonAccount.dart';
import 'widgets/IconText.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      children: [
        //* Name *//
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Alam Brito"),
            ],
          ),
        ),

        //* Avatar *//
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.account_circle_sharp,
                color: Colors.black,
                size: 120,
              ),
            ],
          ),
        ),

        //* Phone *//
        const IconTextWidget(
          icon: Icons.phone_android_rounded,
          text: '0987654321',
        ),

        //* Email *//
        const IconTextWidget(
          icon: Icons.mail,
          text: 'alam.brito@ug.edu.ec',
        ),

        //* Genre *//
        const IconTextWidget(
          icon: Icons.mood_rounded,
          text: 'Masculino',
        ),

        //* Job *//
        const IconTextWidget(
          icon: Icons.work_rounded,
          text: 'Estudiante',
        ),

        //* Username *//
        const IconTextWidget(
          icon: Icons.person_sharp,
          text: 'Alam_B',
        ),

        //* Btn Edit *//
        ButtonAccount(
          text: "EDITAR DATOS",
          onPressed: () {},
        ),

        //* Btn Exit *//
        ButtonAccount(
          text: "CERRAR SESIÓN",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LogInPage()),
            );
          },
        ),
      ],
    );
  }
}
