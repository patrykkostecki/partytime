import 'package:flutter/material.dart';
import 'package:partytime/config/app_routes.dart';
import 'package:partytime/style/app_colors.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

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
              "Wynik",
              style: TextStyle(
                fontFamily: 'Jomhuria',
                fontSize: 96,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: AppColors.basicButton,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: players.map((p) {
                    return Row(
                      children: [
                        const Spacer(),
                        Text(
                          p,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${scores[p] ?? 0} pkt",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                      ],
                    );
                  }).toList(),
                ),
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
