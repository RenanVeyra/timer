import 'package:flutter/material.dart';
import 'package:timer/screens/displayScreen.dart';
import 'themes/customTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //bool darkMode = false;
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //color: Color.fromRGBO(18, 24, 32, 1),
      //theme: ThemeData.dark(useMaterial3: true),
      theme: themeDataByKey('builtin-salmon-midnight'),
      home: const Displayscreen(),
    );
  }
}
