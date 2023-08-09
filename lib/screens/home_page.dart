import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool imageSelected = false;
  bool imageScanning = false;
  XFile? selectedImage;
  String scannedText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OCR"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!imageScanning && selectedImage == null)
              Container(
                width: 300,
                height: 250,
                // color: Colors.green,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
            if (selectedImage != null) Image.file(File(selectedImage!.path)),
            ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: Text("Gallery")),
            ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                child: Text("Camera")),
            Text(scannedText),
          ],
        ),
      ),
    );
  }

  void getImage(imageSource) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: imageSource);
      if (pickedImage != null) {
        imageScanning = true;
        selectedImage = pickedImage;
        setState(() {});
        getTextFromImage(selectedImage);
      }
    } catch (e) {
      // texts
    }
  }

  void getTextFromImage(image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recText = await textDetector.processImage(inputImage);
    textDetector.close();
    scannedText = "";
    for (TextBlock block in recText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    imageScanning = false;
    setState(() {});
  }
}
