import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partytime/components/end_popup.dart';
import 'package:partytime/components/navbar.dart';
import 'package:partytime/config/app_routes.dart';
import 'package:partytime/style/app_colors.dart';

class MixPage extends StatefulWidget {
  const MixPage({super.key});
  @override
  State<MixPage> createState() => _MixGamePageState();
}

class _MixGamePageState extends State<MixPage>
    with SingleTickerProviderStateMixin {
  List<String> _players = [];
  Map<String, int> _scores = {};
  List<String> _mix = [];
  List<String> _availableQuestions = [];
  List<String> _availableChallenges = [];
  int _currentPlayerIndex = 0;
  String? _currentItem;
  String _difficulty = 'easy';
  String _mode = 'random';
  bool _loaded = false;
  bool _loading = true;
  late final AnimationController _swipeCtrl;
  late final Animation<double> _dx;
  late final Animation<double> _rot;
  late final Animation<double> _fade;
  late final Animation<double> _backLiftScale;
  late final Animation<double> _backLiftDy;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _swipeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    final curve = CurvedAnimation(
      parent: _swipeCtrl,
      curve: Curves.easeInOutCubic,
    );
    _dx = Tween<double>(begin: 0, end: 520).animate(curve);
    _rot = Tween<double>(begin: 0, end: 0.20).animate(
      CurvedAnimation(
        parent: _swipeCtrl,
        curve: const Interval(0.0, 0.9, curve: Curves.easeOut),
      ),
    );
    _fade = Tween<double>(begin: 1.0, end: 0.0).animate(curve);
    _backLiftScale = Tween<double>(begin: 0.96, end: 1.0).animate(curve);
    _backLiftDy = Tween<double>(begin: 14, end: 0).animate(curve);
  }

  @override
  void dispose() {
    _swipeCtrl.dispose();
    super.dispose();
  }

  void _showBar(
    String text, {
    IconData icon = Icons.info_outline,
    Color? color,
    Duration duration = const Duration(milliseconds: 900),
  }) {
    final bg = color ?? Colors.black87;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: bg,
        elevation: 8,
        duration: duration,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        showCloseIcon: true,
      ),
    );
  }

  void _endGame() {
    _showBar(
      'Koniec gry!',
      icon: Icons.celebration_outlined,
      color: AppColors.questionGame,
      duration: const Duration(milliseconds: 1000),
    );
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(
        AppRoutes.score,
        arguments: {
          'players': _players,
          'scores': _scores,
          'game': 'mix',
          'difficulty': _difficulty,
        },
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
        {};
    _players = (args['players'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList();
    _difficulty = (args['difficulty'] as String?) ?? 'easy';
    _mode = (args['mode'] as String?) ?? 'random';
    for (final p in _players) {
      _scores.putIfAbsent(p, () => 0);
    }
    _loadMix();
    _loaded = true;
  }

  Future<String?> _askChoice() async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.black87,
        title: const Text(
          'Co wybierasz?',
          style: TextStyle(
            fontFamily: 'Jomhuria',
            fontSize: 42,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.questionGame,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () => Navigator.pop(ctx, 'question'),
              child: const Text(
                'Pytanie',
                style: TextStyle(
                  fontFamily: 'Jomhuria',
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.challangeGame,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () => Navigator.pop(ctx, 'challenge'),
              child: const Text(
                'Wyzwanie',
                style: TextStyle(
                  fontFamily: 'Jomhuria',
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadMix() async {
    setState(() => _loading = true);
    try {
      final questionsSnapshot = await FirebaseFirestore.instance
          .collection('questions')
          .where('difficulty', isEqualTo: _difficulty)
          .get();
      final challengesSnapshot = await FirebaseFirestore.instance
          .collection('challenges')
          .where('difficulty', isEqualTo: _difficulty)
          .get();
      _availableQuestions = questionsSnapshot.docs
          .map((d) => (d.data()['text'] as String?)?.trim())
          .whereType<String>()
          .toList();
      _availableChallenges = challengesSnapshot.docs
          .map((d) => (d.data()['text'] as String?)?.trim())
          .whereType<String>()
          .toList();

      final combined = [
        ..._availableQuestions.map((q) => 'P: $q'),
        ..._availableChallenges.map((c) => 'W: $c'),
      ];

      if (_mode == 'random') {
        combined.shuffle(Random());
        setState(() {
          _mix = combined;
          _currentItem = _mix.removeLast();
          _loading = false;
        });
      } else if (_mode == 'choice') {
        setState(() {
          _mix = [];
          _currentItem = null;
          _loading = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          final choice = await _askChoice();
          if (choice != null) _loadFirstChoice(choice);
        });
      } else {
        setState(() {
          _mix = [];
          _currentItem = null;
          _loading = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) => _endGame());
      }
    } catch (e) {
      setState(() {
        _mix = [];
        _currentItem = null;
        _loading = false;
      });
      _showBar(
        'Błąd ładowania: $e',
        icon: Icons.error_outline,
        color: Colors.redAccent,
      );
    }
  }

  Future<void> _loadFirstChoice(String choice) async {
    String? randomItem;
    if (choice == 'question' && _availableQuestions.isNotEmpty) {
      _availableQuestions.shuffle();
      randomItem = _availableQuestions.removeLast();
    } else if (choice == 'challenge' && _availableChallenges.isNotEmpty) {
      _availableChallenges.shuffle();
      randomItem = _availableChallenges.removeLast();
    }

    if (randomItem != null) {
      setState(() {
        _currentItem = (choice == 'question' ? 'P: ' : 'W: ') + randomItem!;
      });
    } else {
      _endGame();
    }
  }

  Future<void> _onAction({bool point = false, bool shot = false}) async {
    if (_isAnimating || _currentItem == null) return;
    setState(() => _isAnimating = true);
    await _swipeCtrl.forward();
    await _nextTurn(point: point, shot: shot);
    _swipeCtrl.reset();
    if (mounted) setState(() => _isAnimating = false);
  }

  Future<void> _nextTurn({bool point = false, bool shot = false}) async {
    if (_currentItem == null) {
      _endGame();
      return;
    }
    final currentPlayer = _players.isNotEmpty
        ? _players[_currentPlayerIndex]
        : 'Brak gracza';
    if (point) {
      _scores[currentPlayer] = (_scores[currentPlayer] ?? 0) + 1;
      _showBar(
        'Punkt dla $currentPlayer!',
        icon: Icons.star_border_rounded,
        color: AppColors.questionGame,
      );
    }
    if (shot) {
      _showBar(
        '$currentPlayer – pijesz!',
        icon: Icons.local_bar_outlined,
        color: AppColors.challangeGame,
      );
    }

    String? next;
    if (_mode == 'choice') {
      final choice = await _askChoice();
      if (choice == 'question' && _availableQuestions.isNotEmpty) {
        _availableQuestions.shuffle();
        final item = _availableQuestions.removeLast();
        next = 'P: $item';
      } else if (choice == 'challenge' && _availableChallenges.isNotEmpty) {
        _availableChallenges.shuffle();
        final item = _availableChallenges.removeLast();
        next = 'W: $item';
      }
    } else {
      next = _mix.isNotEmpty ? _mix.removeLast() : null;
    }

    if (next == null) {
      _endGame();
      return;
    }

    setState(() {
      _currentPlayerIndex = (_currentPlayerIndex + 1) % _players.length;
      _currentItem = next;
    });
  }

  String? get _nextPreview => _mix.isNotEmpty ? _mix.last : null;

  @override
  Widget build(BuildContext context) {
    final currentPlayer = _players.isNotEmpty
        ? _players[_currentPlayerIndex]
        : 'Brak gracza';
    final isQuestion = _currentItem?.startsWith('P: ') ?? false;
    final currentText = _currentItem?.substring(3) ?? '';
    return Scaffold(
      appBar: Navbar(
        centerImagePath: isQuestion
            ? 'assets/pictures/question.png'
            : 'assets/pictures/glass-cheers.png',
        centerImageColor: isQuestion
            ? AppColors.questionGame
            : AppColors.challangeGame,
        rightImagePath: 'assets/pictures/end.png',
        rightTap: () async {
          final ok = await showEndGameConfirmDialog(context);
          if (ok) _endGame();
        },
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isQuestion
                  ? 'assets/backgrounds/b1.png'
                  : 'assets/backgrounds/b1.png',
            ),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.dstATop,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: _loading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    const SizedBox(height: 27),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Jomhuria',
                          fontSize: 96,
                          height: 0.8,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: isQuestion
                                ? 'Pytanie\ndla '
                                : 'Wyzwanie\ndla ',
                          ),
                          TextSpan(text: currentPlayer),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: 300,
                      height: 220,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (_nextPreview != null)
                            AnimatedBuilder(
                              animation: _swipeCtrl,
                              builder: (context, _) {
                                return Transform.translate(
                                  offset: Offset(0, _backLiftDy.value),
                                  child: Transform.scale(
                                    scale: _backLiftScale.value,
                                    child: _MixCard(
                                      text: _nextPreview!.substring(3),
                                      dimmed: true,
                                    ),
                                  ),
                                );
                              },
                            ),
                          AnimatedBuilder(
                            animation: _swipeCtrl,
                            builder: (context, _) {
                              return Opacity(
                                opacity: _fade.value,
                                child: Transform.translate(
                                  offset: Offset(_dx.value, 0),
                                  child: Transform.rotate(
                                    angle: _rot.value,
                                    child: _MixCard(
                                      text: currentText,
                                      dimmed: false,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 70.0),
                      child: SizedBox(
                        width: 270,
                        height: 78,
                        child: ElevatedButton(
                          onPressed: () => _onAction(point: true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.questionGame,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Punkt',
                            style: TextStyle(
                              fontFamily: 'Jomhuria',
                              fontSize: 64,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 70.0),
                      child: SizedBox(
                        width: 270,
                        height: 78,
                        child: ElevatedButton(
                          onPressed: () => _onAction(shot: true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.challangeGame,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Szot',
                            style: TextStyle(
                              fontFamily: 'Jomhuria',
                              fontSize: 64,
                              color: Colors.white,
                            ),
                          ),
                        ),
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

class _MixCard extends StatelessWidget {
  const _MixCard({required this.text, this.dimmed = false});
  final String text;
  final bool dimmed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.basicButton.withOpacity(dimmed ? 0.75 : 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.08), width: 1.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'PlexSans',
              fontSize: 20,
              color: Colors.white.withOpacity(dimmed ? 0.85 : 1.0),
              fontWeight: FontWeight.bold,
              height: 1.25,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
