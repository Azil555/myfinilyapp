import 'package:flutter/material.dart';

class Person extends StatelessWidget {
  const Person({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Персона"),
      ),
      body: const Center(
        child: Text(
          "Экран Person",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
