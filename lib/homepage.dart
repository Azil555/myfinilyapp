import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String recognizedText = ""; // распознанный текст
  File? _image;

  Future<void> scanText() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText result = await textRecognizer.processImage(inputImage);

    setState(() {
      recognizedText = result.text;
      _image = File(image.path);
    });

    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Главная страница"),
        backgroundColor: const Color.fromARGB(255, 88, 202, 255),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
             decoration: BoxDecoration(
                color: Color.fromARGB(255, 88, 202, 255),
              ),
              child: Text(
                "Меню",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Главная"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Сканировать текст"),
              onTap: () {
                Navigator.pop(context);
                scanText();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("О приложении"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("О приложении"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // Кнопка-плюсик в углу
      floatingActionButton: FloatingActionButton(
        onPressed: scanText,
        backgroundColor: const Color.fromARGB(255, 88, 202, 255),
        child: const Icon(Icons.add), // плюсик
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_image != null)
              Image.file(
                _image!,
                height: 200,
              ),
            const SizedBox(height: 20),
            if (recognizedText.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    recognizedText,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 10,
                      height: 200,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text("Кнопка 1"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 10,
                      height: 200,
                      child: ElevatedButton( 
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text("Кнопка 2"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 10,
                      height: 200,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text("Кнопка 3"),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}