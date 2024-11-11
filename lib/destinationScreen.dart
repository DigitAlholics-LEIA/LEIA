import 'package:flutter/material.dart';

class DestinationScreen extends StatelessWidget {
  final String label;

  const DestinationScreen(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: Center(
        child: Text("Bienvenido a $label"),
      ),
    );
  }
}
