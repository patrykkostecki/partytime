import 'package:flutter/material.dart';
import 'package:partytime/config/app_routes.dart';
import 'package:partytime/style/app_colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 85),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/pictures/logo (2).png',
                width: 241,
                height: 274,
              ),
              Text(
                'PartyTime',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontFamily: "Jura",
                ),
              ),
              Spacer(),
              SizedBox(
                height: 58,
                width: 236,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.start);
                  },
                  child: Text(
                    'Zaczynajmy!',
                    style: TextStyle(fontSize: 48, fontFamily: "Jomhuria"),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.firstButton,
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
