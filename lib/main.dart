import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const PDFViewerApp());
}

class PDFViewerApp extends StatelessWidget {
  const PDFViewerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDF Viewer',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black87),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
