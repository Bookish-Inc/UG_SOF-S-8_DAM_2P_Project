import 'package:flutter/material.dart';

class HomePage  extends StatefulWidget {
  const HomePage ({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _State();
}

class _State extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Home", style: TextStyle(fontSize: 30),),
    );
  }
}
