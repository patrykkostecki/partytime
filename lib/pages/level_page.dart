import 'package:flutter/material.dart';
import 'package:partytime/components/navbar.dart';
import 'package:partytime/config/app_routes.dart';
import 'package:partytime/style/app_colors.dart';

class LevelPage extends StatelessWidget {
  const LevelPage({super.key});

  String _getGameRoute(String game) {
    switch (game) {
      case 'mix':
        return AppRoutes.mix;
      case 'challenge':
        return AppRoutes.challange;
      case 'questions':
        return AppRoutes.question;
      case 'never':
        return AppRoutes.never;
      default:
        return AppRoutes.mix;
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
        {};
    final List<String> players = (args['players'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList();
    final String game = args['game'] as String? ?? 'mix';

    void _goToGame(String difficulty) {
      final route = _getGameRoute(game);
      Navigator.of(context).pushNamed(
        route,
        arguments: {'players': players, 'game': game, 'difficulty': difficulty},
      );
    }

    return Scaffold(
      appBar: Navbar(
        centerImagePath: 'assets/pictures/PartyTime.png',
        Width: 51,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 27),
            const Text(
              "Wybierz poziom\n      trudności",
              style: TextStyle(
                fontFamily: 'Jomhuria',
                fontSize: 80,
                color: Colors.white,
                height: 0.8,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 325,
              height: 116,
              child: ElevatedButton(
                onPressed: () => _goToGame('easy'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.easybutton,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                child: const Text(
                  'Dla leszczy',
                  style: TextStyle(fontSize: 64, fontFamily: "Jomhuria"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 325,
              height: 116,
              child: ElevatedButton(
                onPressed: () => _goToGame('normal'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.normalbutton,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                child: const Text(
                  'Normalny',
                  style: TextStyle(fontSize: 64, fontFamily: "Jomhuria"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 325,
              height: 116,
              child: ElevatedButton(
                onPressed: () => _goToGame('hard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.hardbutton,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                child: const Text(
                  'Trudny',
                  style: TextStyle(fontSize: 64, fontFamily: "Jomhuria"),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
