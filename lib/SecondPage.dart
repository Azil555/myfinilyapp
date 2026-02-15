import 'package:flutter/material.dart';
import 'homePage.dart'; 

class SecondPage extends StatefulWidget {
  final String name;
  final String surname;
  final String email;

  const SecondPage({
    super.key,
    required this.name,
    required this.surname,
    required this.email,
  });

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int current = 0;
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Which word has the sound /b/?',
      'answers': ['pen', 'book', 'sun'],
      'correct': 1,
    },
    {
      'question': 'Choose the correct sentence:',
      'answers': ['He go to school', 'He goes to school', 'He going school'],
      'correct': 1,
    },
    {
      'question': 'What do you get if D + A?',
      'answers': ['DA', 'DD', 'aD'],
      'correct': 0,
    },
    {
      'question': 'Is the word "runing" correct?',
      'answers': ['yes', 'no', 'idk'],
      'correct': 1,
    },
  ];


  String getDiagnosis() {
    double percent = score / questions.length;
    if (percent < 0.5) {
      return "сс";
    } else {
      return "Dyslexia is unlikely";
    }
  }

  void selectAnswer(int index) {
    if (index == questions[current]['correct']) score++;

    if (current < questions.length - 1) {
      setState(() {
        current++;
      });
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "TEST RESULT",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "You typed: $score from ${questions.length}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        getDiagnosis(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            name: widget.name,
                            surname: widget.surname, 
                            email: widget.email,
                          ),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("The Dyslexia test")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              questions[current]['question'],
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...List.generate(
              questions[current]['answers'].length,
              (i) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => selectAnswer(i),
                    child: Text(questions[current]['answers'][i]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}