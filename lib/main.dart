import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Jomhuria',
        scaffoldBackgroundColor: Color(0xff0A0101),
      ),
    );
  }
}
