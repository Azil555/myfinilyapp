import 'package:flutter/material.dart';
import 'secondPage.dart';
import 'registerdialog.dart';

void main() => runApp(const MaterialApp(home: StartPage(), debugShowCheckedModeBanner: false));

class StartPage extends StatefulWidget {
  const StartPage({super.key});
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String name = "Guest";
  String surname = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const RegisterDialog(),
      );

      if (result != null && result is Map<String, String>) {
        setState(() {
          name = result['name'] ?? "Guest";
          surname = result['surname'] ?? "";
          email = result['email'] ?? "";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dyslexia Helper"), 
        backgroundColor: const Color.fromARGB(255, 88, 202, 255)
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 88, 202, 255), 
            fixedSize: const Size(300, 60)
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondPage(
                  name: name, 
                  surname: surname, 
                  email: email,
                ),
              ),
            );
          },
          child: const Text("Start Learning", style: TextStyle(fontSize: 20, color: Colors.black)),
        ),
      ),
    );
  }
}