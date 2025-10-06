import 'package:flutter/material.dart';
import 'package:partytime/config/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // wygeneruje Ci flutterfire CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
