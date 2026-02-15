import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class HomePage extends StatefulWidget {
  final String name;
  final String surname;
  final String email;

  const HomePage({
    super.key,
    required this.name,
    required this.surname,
    required this.email,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final Color brandColor = const Color.fromARGB(255, 88, 202, 255);

  File? _image;
  String _scannedText = "Scan a photo to see text here...";
  bool _isScanning = false;

  final List<Map<String, dynamic>> exercises = [
    {"q": "Letter 'b' or 'd'?", "content": "In the word '_og' (barking animal), which letter is missing?", "answer": "d"},
    {"q": "Extra letter", "content": "Find the extra letter in this row: AAAABAA", "answer": "b"},
    {"q": "Word building", "content": "Combine syllables: WA-TER", "answer": "water"},
    {"q": "Mirror letters", "content": "Which letter is correct: 'S' or 'Ƨ'?", "answer": "s"},
    {"q": "Rhyme", "content": "Find a rhyme for 'Cat': Hat, Box, or Sun?", "answer": "hat"},
    {"q": "Missing letter", "content": "What is missing: S_NNY (Weather)?", "answer": "u"},
    {"q": "Unscramble", "content": "Unscramble the letters: D-O-G", "answer": "dog"},
    {"q": "Syllable count", "content": "How many syllables in 'Ba-na-na'?", "answer": "3"},
    {"q": "Vowels", "content": "What is the first vowel in 'Apple'?", "answer": "a"},
    {"q": "Ending", "content": "What is the last letter of 'Book'?", "answer": "k"},
    {"q": "Phonics", "content": "What sound does 'Snake' start with?", "answer": "s"},
    {"q": "Colors", "content": "Spell the color 'Blue' correctly", "answer": "blue"},
    {"q": "Shapes", "content": "What shape looks like the letter 'O'?", "answer": "circle"},
    {"q": "Opposites", "content": "What is the opposite of 'Big'?", "answer": "small"},
    {"q": "Double letters", "content": "How many 'p's are in 'Apple'?", "answer": "2"},
    {"q": "Prepositions", "content": "The cat is _ the table (Under or Over?)", "answer": "under"},
    {"q": "Numbers", "content": "Write the number '5' as a word", "answer": "five"},
    {"q": "Plurals", "content": "One dog, many ...?", "answer": "dogs"},
    {"q": "Logic", "content": "Which is a fruit: Apple or Carrot?", "answer": "apple"},
    {"q": "Spelling", "content": "Correct the word: 'Skuul'", "answer": "school"},
    {"q": "First letter", "content": "What is the first letter of the Alphabet?", "answer": "a"},
    {"q": "Animals", "content": "What animal says 'Meow'?", "answer": "cat"},
    {"q": "Solar system", "content": "Which planet do we live on?", "answer": "earth"},
    {"q": "Days", "content": "What day comes after Monday?", "answer": "tuesday"},
    {"q": "Final task", "content": "Type the word 'Learning'", "answer": "learning"},
  ];

  int solvedCount = 0;

  Future<void> _pickAndRecognizeText() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _isScanning = true;
      });

      final inputImage = InputImage.fromFile(_image!);
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      
      try {
        final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
        setState(() {
          _scannedText = recognizedText.text.isEmpty ? "No text found" : recognizedText.text;
        });
      } catch (e) {
        setState(() => _scannedText = "Error scanning text.");
      } finally {
        textRecognizer.close();
        setState(() => _isScanning = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildLevelsGrid(),
      _buildScannerPage(),
      _buildProfilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? "Levels" : _currentIndex == 1 ? "Scanner" : "Profile"),
        backgroundColor: brandColor,
        automaticallyImplyLeading: false, 
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: brandColor,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Levels"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "Scanner"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildLevelsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, crossAxisSpacing: 15, mainAxisSpacing: 15,
      ),
      itemCount: exercises.length,
      itemBuilder: (ctx, i) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: brandColor,
          elevation: 4,
        ),
        onPressed: () => _openExercise(i),
        child: Text("${i + 1}", style: const TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }

  void _openExercise(int index) {
    final TextEditingController _answerController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(exercises[index]['q'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(exercises[index]['content'], style: const TextStyle(fontSize: 18)),
              const Spacer(),
              TextField(
                controller: _answerController,
                decoration: const InputDecoration(labelText: "Your answer", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: brandColor, minimumSize: const Size(double.infinity, 50)),
                onPressed: () {
                  // CHECK ANSWER
                  if (_answerController.text.trim().toLowerCase() == exercises[index]['answer'].toString().toLowerCase()) {
                    setState(() {
                      solvedCount++;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Correct! 🎉"), backgroundColor: Colors.green),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Try again ❌"), backgroundColor: Colors.red),
                    );
                  }
                },
                child: const Text("Check Answer", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScannerPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (_image != null) Image.file(_image!, height: 200),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _pickAndRecognizeText,
            icon: const Icon(Icons.camera),
            label: const Text("Take Photo for Scan"),
            style: ElevatedButton.styleFrom(backgroundColor: brandColor, foregroundColor: Colors.white),
          ),
          const SizedBox(height: 20),
          if (_isScanning) const CircularProgressIndicator(),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
            child: Text(_scannedText, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePage() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 30),
          CircleAvatar(
            radius: 50,
            backgroundColor: brandColor,
            child: const Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Text("${widget.name} ${widget.surname}", 
               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(widget.email, 
               style: const TextStyle(color: Colors.grey, fontSize: 16)),
          const Divider(height: 40),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.orange), 
            title: const Text("My Progress"), 
            trailing: Text("$solvedCount / 25") 
          ),
          const ListTile(
            leading: Icon(Icons.settings), 
            title: Text("Settings")
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst), 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent, 
              minimumSize: const Size(double.infinity, 50)
            ),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}