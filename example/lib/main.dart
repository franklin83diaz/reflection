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
            Center(
              child: Row(
                children: [
                  const Spacer(),
                  Reflection(
                    settingReflection: SettingReflection(
                      skewX: 0.2,
                      scaleY: 0.5,
                      opacity: 0.9,
                      reflectionLength: 0.4,
                      positionX: 0.2,
                      expandRight: 10,
                      below: -32,
                    ),
                    child: const Text('Hello World ',
                        style: TextStyle(
                            fontSize: 60,
                            color: Color.fromARGB(255, 15, 35, 90))),
                  ),
                  Reflection(
                    settingReflection: SettingReflectionEnum.image.setting,
                    child: Container(
                      color: Colors.red,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
