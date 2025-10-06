// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partytime/components/navbar.dart';
import 'package:partytime/config/app_routes.dart';
import 'package:partytime/style/app_colors.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({super.key});

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  final TextEditingController _countCtrl = TextEditingController(text: "0");
  final List<TextEditingController> _nameCtrls = [];
  int _playerCount = 0;
  String _selectedGame = 'mix';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final incomingGame = args?['game'];
    if (incomingGame is String) {
      _selectedGame = incomingGame;
    }
  }

  @override
  void dispose() {
    _countCtrl.dispose();
    for (final c in _nameCtrls) {
      c.dispose();
    }
    super.dispose();
  }

  void _setPlayerCount(int n) {
    final int target = n.clamp(0, 20);
    if (target == _playerCount) return;

    setState(() {
      while (_nameCtrls.length < target) {
        _nameCtrls.add(TextEditingController());
      }
      while (_nameCtrls.length > target) {
        _nameCtrls.removeLast().dispose();
      }
      _playerCount = target;
    });
  }

  void _onStart() {
    if (_playerCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Najpierw podaj liczbę graczy.')),
      );
      return;
    }

    final players = List<String>.generate(_playerCount, (i) {
      final txt = _nameCtrls[i].text.trim();
      return txt.isEmpty ? 'Gracz ${i + 1}' : txt;
    });

    Navigator.of(context).pushNamed(
      AppRoutes.level,
      arguments: {'players': players, 'game': _selectedGame},
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: Navbar(
          centerImagePath: 'assets/pictures/PartyTime.png',
          Width: 51,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 27),
              const Text(
                'Podaj ilość\n    graczy',
                style: TextStyle(
                  fontSize: 96,
                  fontFamily: 'Jomhuria',
                  color: Colors.white,
                  height: 0.67,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 156,
                height: 58,
                decoration: BoxDecoration(
                  color: AppColors.input,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 13),
                    UnconstrainedBox(
                      child: SizedBox(
                        height: 37,
                        width: 37,
                        child: Image.asset('assets/pictures/people-group.png'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 70,
                      height: 40,
                      child: TextField(
                        controller: _countCtrl,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (v) {
                          final n = int.tryParse(v) ?? 0;
                          _setPlayerCount(n);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: AppColors.ininput),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: AppColors.ininput),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: AppColors.ininput),
                          ),
                          hintText: "0",
                          hintStyle: const TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: const Color.fromARGB(99, 156, 152, 152),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  itemCount: _playerCount,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    return Row(
                      children: [
                        Container(
                          width: 280,
                          height: 58,
                          decoration: BoxDecoration(
                            color: AppColors.input,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 13),
                              UnconstrainedBox(
                                child: SizedBox(
                                  height: 37,
                                  width: 37,
                                  child: Image.asset(
                                    'assets/pictures/user.png',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                width: 190,
                                height: 40,
                                child: TextField(
                                  controller: _nameCtrls[i],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: AppColors.ininput,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: AppColors.ininput,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: AppColors.ininput,
                                      ),
                                    ),
                                    hintText: 'Gracz ${i + 1}',
                                    hintStyle: const TextStyle(
                                      color: Colors.white54,
                                    ),
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                      99,
                                      156,
                                      152,
                                      152,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 58,
                          height: 58,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _nameCtrls.removeAt(i).dispose();
                                _playerCount -= 1;
                                _countCtrl.text = '$_playerCount';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.input,
                            ),
                            child: UnconstrainedBox(
                              child: SizedBox(
                                width: 10,
                                height: 10,
                                child: Image.asset('assets/pictures/minus.png'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _onStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.firstButton,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Zaczynajmy!',
                  style: TextStyle(fontSize: 48, fontFamily: "Jomhuria"),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
