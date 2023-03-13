import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  const IconTextWidget({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(40, 24, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 24,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
