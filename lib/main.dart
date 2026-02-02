import 'package:flutter/material.dart';
import 'SecondPage.dart'; // для перехода на тест

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StartPage(),
    );
  }
}

// Стартовое окно с кнопкой "Start Test"
class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dyslexia Helper"),
        backgroundColor: const Color.fromARGB(255, 88, 202, 255),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(300, 60),
            backgroundColor: const Color.fromARGB(255, 88, 202, 255),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            "Start Test",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
