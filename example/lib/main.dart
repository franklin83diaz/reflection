import 'package:flutter/material.dart';
import 'package:reflection/reflection_effect.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Example Reflection Widget',
      home: Scaffold(
        body: Center(
          child: Reflection(
            negativeSpace: 20,
            child: Text('Hello World',
                style: TextStyle(fontSize: 30, color: Colors.blue)),
          ),
        ),
      ),
    );
  }
}
