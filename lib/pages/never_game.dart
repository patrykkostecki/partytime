import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partytime/components/end_popup.dart';
import 'package:partytime/components/navbar.dart';
import 'package:partytime/config/app_routes.dart';
import 'package:partytime/style/app_colors.dart';

class NeverGame extends StatefulWidget {
  const NeverGame({super.key});

  @override
  State<NeverGame> createState() => _NeverGameState();
}

class _NeverGameState extends State<NeverGame>
    with SingleTickerProviderStateMixin {
  List<String> _statements = [];
  String? _current;
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
      'Koniec kart!',
      icon: Icons.celebration_outlined,
      color: AppColors.challangeGame,
      duration: const Duration(milliseconds: 1000),
    );
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      Navigator.of(context).pushNamed(AppRoutes.scoreNever);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
        {};
    _difficulty = (args['difficulty'] as String?) ?? 'easy';

    _loadNever();
    _loaded = true;
  }

  Future<void> _loadNever() async {
    setState(() => _loading = true);
    try {
      Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(
        'never',
      );
      if (_difficulty.isNotEmpty) {
        query = query.where('difficulty', isEqualTo: _difficulty);
      }

      final snapshot = await query.get();

      final all = snapshot.docs
          .map((d) => (d.data()['text'] as String?)?.trim())
          .whereType<String>()
          .where((t) => t.isNotEmpty)
          .toList();

      all.shuffle(Random());

      if (all.isEmpty) {
        setState(() {
          _statements = [];
          _current = null;
          _loading = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) => _endGame());
        return;
      }

      setState(() {
        _statements = all;
        _current = _statements.removeLast();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _statements = [];
        _current = null;
        _loading = false;
      });
      _showBar(
        'Błąd ładowania: $e',
        icon: Icons.error_outline,
        color: Colors.redAccent,
      );
    }
  }

  Future<void> _onNext() async {
    if (_isAnimating || _current == null) return;
    setState(() => _isAnimating = true);
    await _swipeCtrl.forward();
    _nextCard();
    _swipeCtrl.reset();
    if (mounted) setState(() => _isAnimating = false);
  }

  void _nextCard() {
    final String? next = _statements.isNotEmpty
        ? _statements.removeLast()
        : null;

    if (next == null) {
      setState(() => _current = null);
      _endGame();
      return;
    }

    setState(() => _current = next);
  }

  String? get _nextPreview => _statements.isNotEmpty ? _statements.last : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        centerImagePath: "assets/pictures/cards-blank.png",
        centerImageColor: AppColors.challangeGame,
        rightImagePath: 'assets/pictures/end.png',
        rightTap: () async {
          final ok = await showEndGameConfirmDialog(context);
          if (ok) _endGame();
        },
      ),

      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/backgrounds/b2.png'),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
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
                    Spacer(),
                    const SizedBox(height: 27),
                    const Text(
                      "Nigdy\nprzenigdy",
                      style: TextStyle(
                        fontFamily: 'Jomhuria',
                        fontSize: 96,
                        color: Colors.white,
                        height: 0.80,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),

                    // ---- STOS KART ----
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
                                    child: _NeverCard(
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
                                    child: _NeverCard(
                                      text: _current ?? '',
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
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: 270,
                        height: 78,
                        child: ElevatedButton(
                          onPressed: _onNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.challangeGame,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Next',
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

class _NeverCard extends StatelessWidget {
  const _NeverCard({required this.text, this.dimmed = false});

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
