import 'package:flutter/material.dart';
import 'package:reflection_effect/reflection_effect.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Example Reflection Widget',
      home: Scaffold(
        body: Stack(
          children: [
            Center(child: Image.asset('images/backgraund.png')),
            const Center(
              child: Reflection(
                negativeSpace: 30,
                child: Text('Hello World',
                    style: TextStyle(
                        fontSize: 40, color: Color.fromARGB(255, 15, 35, 90))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
