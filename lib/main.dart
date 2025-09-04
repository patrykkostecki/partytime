import 'package:flutter/material.dart';
import 'package:partytime/config/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'PlexSans',
        scaffoldBackgroundColor: Color(0xff0A0101),
      ),
      initialRoute: "/",
      routes: AppRoutes.routes,
    );
  }
}
