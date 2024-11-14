import 'package:flutter/material.dart';
import 'package:leia/ui/path_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Language Route',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PathView(specialtyId: 1,), // Cambiado a LanguageView para evitar conflictos
    );
  
  }
}
