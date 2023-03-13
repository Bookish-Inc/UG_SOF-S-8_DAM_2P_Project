import 'package:flutter/material.dart';

class ButtonLogIn extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color buttonColor;
  final VoidCallback onPressed;

  const ButtonLogIn(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.buttonColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: MaterialButton(
        onPressed: onPressed,
        color: buttonColor,
        // color: Colors.white,
        height: 50.0,
        minWidth: 155.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            // color: Colors.indigo,
            fontSize: 25.0,
            fontFamily: 'FredokaOne',
          ),
        ),
      ),
    );
  }
}
