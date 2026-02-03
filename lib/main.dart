import 'package:flutter/material.dart';
import 'SecondPage.dart';
import 'registerdialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  void initState() {
    super.initState();

    // Показываем окно после загрузки страницы
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false, // нельзя закрыть нажатием вне окна
        builder: (context) => const RegisterDialog(),
      );
    });
  }

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
