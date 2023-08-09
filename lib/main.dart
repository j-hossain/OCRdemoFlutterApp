import 'package:flutter/material.dart';
import 'package:ocr_testing/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OCR App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const HomePage(),
    );
  }
}
