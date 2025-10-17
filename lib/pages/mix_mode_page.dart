import 'package:flutter/material.dart';
import 'package:partytime/components/navbar.dart';
import 'package:partytime/config/app_routes.dart';
import 'package:partytime/style/app_colors.dart';

class MixModePage extends StatelessWidget {
  const MixModePage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
        {};
    final players = args['players'] ?? [];
    final difficulty = args['difficulty'] ?? 'easy';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: Navbar(
        centerImagePath: 'assets/pictures/PartyTime.png',
        Width: 51,
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgrounds/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Jak chcesz grać?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Jomhuria',
                    fontSize: 80,
                    color: Colors.white,
                    height: 0.8,
                  ),
                ),
                const SizedBox(height: 60),
                _ModeButton(
                  text: "Losowo",
                  color: AppColors.questionGame,
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.mix,
                      arguments: {
                        'players': players,
                        'difficulty': difficulty,
                        'mode': 'random',
                      },
                    );
                  },
                ),
                const SizedBox(height: 30),
                _ModeButton(
                  text: "Wybór przed",
                  color: AppColors.challangeGame,
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.mix,
                      arguments: {
                        'players': players,
                        'difficulty': difficulty,
                        'mode': 'choice',
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const _ModeButton({
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Jomhuria',
            fontSize: 50,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
