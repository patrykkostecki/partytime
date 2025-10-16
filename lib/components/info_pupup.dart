import 'package:flutter/material.dart';
import 'package:partytime/style/app_colors.dart';

Future<bool> showInfoPopup(BuildContext context, {String title = "Gry"}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(95, 15, 1, 1).withOpacity(0.92),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Jomhuria',
            fontSize: 48,
            color: Colors.white,
            height: 0.9,
          ),
          textAlign: TextAlign.center,
        ),
        content: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: AppColors.mixGame,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: UnconstrainedBox(
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: Image.asset('assets/pictures/mix.png'),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Mix',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
              Text(
                'Połączenie gier z pytaniami oraz wyzwaniami',
                style: TextStyle(
                  fontFamily: 'PlexSans',
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: AppColors.challangeGame,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: UnconstrainedBox(
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: Image.asset('assets/pictures/glass-cheers.png'),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Wyzwania',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
              Text(
                'Gra z wyzwaniami dla kilku osób',
                style: TextStyle(
                  fontFamily: 'PlexSans',
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: AppColors.questionGame,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: UnconstrainedBox(
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: Image.asset('assets/pictures/question.png'),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Pytania',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
              Text(
                'Gra z pytaniami dla kilku osób',
                style: TextStyle(
                  fontFamily: 'PlexSans',
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: AppColors.cardGame,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: UnconstrainedBox(
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: Image.asset('assets/pictures/cards-blank.png'),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Nigdy przenigdy',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
              Text(
                'Nigdy przenigdy...',
                style: TextStyle(
                  fontFamily: 'PlexSans',
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.basicButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
              child: Text(
                'Okej',
                style: TextStyle(
                  fontFamily: 'PlexSans',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
  return result ?? false;
}
