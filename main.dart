import 'package:calculator/calculator_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //change title and theme
      title: 'Calculator',
      theme: ThemeData.dark(),

      //create new widget for calculatorscreen called calculator_screen.dart and import it
      home: const CalculatorScreen(),
    );
  }
}
