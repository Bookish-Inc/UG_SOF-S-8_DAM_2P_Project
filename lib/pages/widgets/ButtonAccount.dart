import 'package:flutter/material.dart';

class ButtonAccount extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ButtonAccount({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: onPressed,
            child: Text(text),
          )
        ],
      ),
    );
  }
}
