import 'package:flutter/material.dart';
import 'package:partytime/components/navbar.dart';
import 'package:partytime/style/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 67),
            Text(
              "Logowanie",
              style: TextStyle(
                fontFamily: "Jomhuria",
                fontSize: 96,
                color: Colors.white,
              ),
            ),
            Spacer(),
            SizedBox(
              width: 236,
              height: 58,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed(AppRoutes.games);
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/pictures/mail.png",
                      width: 37,
                      height: 37,
                    ),
                    SizedBox(width: 30),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontFamily: 'Jomhuria',
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.basicButton,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 236,
              height: 58,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed(AppRoutes.games);
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/pictures/google (1).png",
                      width: 37,
                      height: 37,
                    ),
                    SizedBox(width: 30),
                    Text(
                      'Google',
                      style: TextStyle(
                        fontFamily: 'Jomhuria',
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.basicButton,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 236,
              height: 58,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed(AppRoutes.games);
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/pictures/apple.png",
                      width: 37,
                      height: 37,
                    ),
                    SizedBox(width: 30),
                    Text(
                      'Apple',
                      style: TextStyle(
                        fontFamily: 'Jomhuria',
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.basicButton,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                "Utwórz konto",
                style: TextStyle(
                  fontFamily: "Jomhuria",
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
