import 'package:flutter/material.dart';
import 'package:partytime/config/app_routes.dart';
import 'package:partytime/style/app_colors.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgrounds/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Text(
                  'PartyTime',
                  style: TextStyle(
                    fontFamily: 'Jura',
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "Gry i wyzwania na \nimprezę 18+",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'PlexSans',
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              SizedBox(
                width: 236,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.games);
                  },
                  child: Text(
                    'Wybierz grę',
                    style: TextStyle(
                      fontFamily: 'Jomhuria',
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.firstButton,
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
                    Navigator.of(context).pushNamed(AppRoutes.login);
                  },
                  child: Text(
                    'Zaloguj się',
                    style: TextStyle(
                      fontFamily: 'Jomhuria',
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.seondButton,
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
                    Navigator.of(context).pushNamed(AppRoutes.settings);
                  },
                  child: Text(
                    'Ustawienia',
                    style: TextStyle(
                      fontFamily: 'Jomhuria',
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.thirdButton,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
