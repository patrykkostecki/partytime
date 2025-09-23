// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:partytime/components/navbar.dart';
import 'package:partytime/config/app_routes.dart';
import 'package:partytime/style/app_colors.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
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
              const SizedBox(height: 59),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.players);
                },
                child: Container(
                  width: 120,
                  height: 100,
                  child: UnconstrainedBox(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/pictures/mix.png'),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.mixGame,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.challange);
                    },
                    child: Container(
                      width: 140,
                      height: 140,
                      child: UnconstrainedBox(
                        child: SizedBox(
                          width: 78,
                          height: 78,
                          child: Image.asset(
                            'assets/pictures/glass-cheers.png',
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.challangeGame,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.players);
                    },
                    child: Container(
                      width: 140,
                      height: 140,
                      child: UnconstrainedBox(
                        child: SizedBox(
                          width: 78,
                          height: 78,
                          child: Image.asset('assets/pictures/question.png'),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.questionGame,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.players);
                },
                child: Container(
                  width: 140,
                  height: 140,
                  child: UnconstrainedBox(
                    child: SizedBox(
                      width: 78, //
                      height: 78,
                      child: Image.asset(
                        'assets/pictures/cards-blank.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cardGame,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                'Wybierz grę',
                style: TextStyle(
                  fontFamily: 'Jomhuria',
                  fontSize: 96,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
