// lib/components/end_game_confirm.dart
import 'package:flutter/material.dart';
import 'package:partytime/style/app_colors.dart';

Future<bool> showEndGameConfirmDialog(
  BuildContext context, {
  String title = 'Zakończyć grę?',
  String message =
      'Na pewno chcesz zakończyć? Zostaniesz przeniesiony do podsumowania.',
  Color? accentColor,
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: const Color(0xff0A0101).withOpacity(0.92),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Jomhuria',
            fontSize: 42,
            color: Colors.white,
            height: 0.9,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'PlexSans',
            fontSize: 16,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.basicButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
            child: Text(
              'Gram dalej',
              style: TextStyle(fontFamily: 'PlexSans', color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor ?? AppColors.challangeGame,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Tak, zakończ',
              style: TextStyle(fontFamily: 'PlexSans', color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
  return result ?? false;
}
