import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partytime/components/end_popup.dart';
import 'package:partytime/components/navbar.dart';
import 'package:partytime/config/app_routes.dart';
import 'package:partytime/style/app_colors.dart';

class QuestionGame extends StatefulWidget {
  const QuestionGame({super.key});

  @override
  State<QuestionGame> createState() => _QuestionGameState();
}

class _QuestionGameState extends State<QuestionGame>
    with SingleTickerProviderStateMixin {
  // ---- stan gry
  List<String> _players = [];
  Map<String, int> _scores = {};
  List<String> _questions = [];
  int _currentPlayerIndex = 0;
  String? _currentQuestion;
  String _difficulty = 'easy';
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
      'Koniec pytań!',
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
          'game': 'question',
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
    for (final p in _players) {
      _scores.putIfAbsent(p, () => 0);
    }
    _loadQuestions();
    _loaded = true;
  }

  Future<void> _loadQuestions() async {
    setState(() => _loading = true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('questions')
          .where('difficulty', isEqualTo: _difficulty)
          .get();

      final all = snapshot.docs
          .map((d) => (d.data()['text'] as String?)?.trim())
          .whereType<String>()
          .where((t) => t.isNotEmpty)
          .toList();

      all.shuffle(Random());

      if (all.isEmpty) {
        setState(() {
          _questions = [];
          _currentQuestion = null;
          _loading = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) => _endGame());
        return;
      }

      setState(() {
        _questions = all;
        _currentQuestion = _questions.removeLast();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _questions = [];
        _currentQuestion = null;
        _loading = false;
      });
      _showBar(
        'Błąd ładowania pytań: $e',
        icon: Icons.error_outline,
        color: Colors.redAccent,
      );
    }
  }

  Future<void> _onAction({bool point = false, bool shot = false}) async {
    if (_isAnimating || _currentQuestion == null) return;
    setState(() => _isAnimating = true);
    await _swipeCtrl.forward();
    _nextTurn(point: point, shot: shot);
    _swipeCtrl.reset();
    if (mounted) setState(() => _isAnimating = false);
  }

  void _nextTurn({bool point = false, bool shot = false}) {
    if (_currentQuestion == null) {
      _endGame();
      return;
    }

    final currentPlayer = _players[_currentPlayerIndex];

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

    final String? nextQuestion = _questions.isNotEmpty
        ? _questions.removeLast()
        : null;

    if (nextQuestion == null) {
      setState(() {
        _currentPlayerIndex = (_currentPlayerIndex + 1) % _players.length;
        _currentQuestion = null;
      });
      _endGame();
      return;
    }

    setState(() {
      _currentPlayerIndex = (_currentPlayerIndex + 1) % _players.length;
      _currentQuestion = nextQuestion;
    });
  }

  String? get _nextPreview => _questions.isNotEmpty ? _questions.last : null;

  @override
  Widget build(BuildContext context) {
    final currentPlayer = _players.isNotEmpty
        ? _players[_currentPlayerIndex]
        : '???';

    return Scaffold(
      appBar: Navbar(
        centerImagePath: "assets/pictures/question.png",
        centerImageColor: AppColors.questionGame,
        rightImagePath: 'assets/pictures/end.png',
        rightTap: () async {
          final ok = await showEndGameConfirmDialog(context);
          if (ok) _endGame();
        },
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/backgrounds/b1.png'),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
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
                    Text(
                      "  Pytanie\ndla $currentPlayer",
                      style: const TextStyle(
                        fontFamily: 'Jomhuria',
                        fontSize: 96,
                        color: Colors.white,
                        height: 0.80,
                      ),
                      textAlign: TextAlign.center,
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
                                    child: _QuestionCard(
                                      text: _nextPreview!,
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
                                    child: _QuestionCard(
                                      text: _currentQuestion ?? '',
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

// pojedyncza karta pytania
class _QuestionCard extends StatelessWidget {
  const _QuestionCard({required this.text, this.dimmed = false});

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
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(child: _QuestionText()),
      ),
    );
  }
}

class _QuestionText extends StatelessWidget {
  const _QuestionText();

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
