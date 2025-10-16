import 'package:flutter/material.dart';
import 'package:partytime/components/navbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: Center(
        child: Text(
          "Wkrótce",
          style: TextStyle(
            fontFamily: 'Jomhuria',
            fontSize: 92,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
