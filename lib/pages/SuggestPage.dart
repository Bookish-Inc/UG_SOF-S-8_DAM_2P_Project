import 'package:flutter/material.dart';

class SuggestPage extends StatefulWidget {
  const SuggestPage({Key? key}) : super(key: key);

  @override
  State<SuggestPage> createState() => _SuggestPageState();
}

class _SuggestPageState extends State<SuggestPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Sugerencias", style: TextStyle(fontSize: 30),),
    );
  }
}
