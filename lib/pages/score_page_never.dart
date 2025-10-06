import 'package:flutter/material.dart';
import 'package:partytime/config/app_routes.dart';
import 'package:partytime/style/app_colors.dart';

class ScorePageNever extends StatelessWidget {
  const ScorePageNever({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
        {};
    final List<String> players = (args['players'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList();
    final Map<String, int> scores =
        (args['scores'] as Map<String, dynamic>? ?? {}).map(
          (k, v) => MapEntry(k, (v as int)),
        );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 67),
            const Text(
              "Koniec kart",
              style: TextStyle(
                fontFamily: 'Jomhuria',
                fontSize: 96,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 278,
              height: 92,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamed(AppRoutes.games, arguments: {'players': players});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.hardbutton,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                child: const Text(
                  'Kolejna gra',
                  style: TextStyle(fontSize: 64, fontFamily: "Jomhuria"),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 278,
              height: 92,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.start);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.basicButton,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                child: const Text(
                  'Koniec',
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
