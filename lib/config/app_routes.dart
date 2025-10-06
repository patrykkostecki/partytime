import 'package:partytime/pages/challange_page.dart';
import 'package:partytime/pages/games_page.dart';
import 'package:partytime/pages/level_page.dart';
import 'package:partytime/pages/login_page.dart';
import 'package:partytime/pages/mix_page.dart';
import 'package:partytime/pages/never_game.dart';
import 'package:partytime/pages/players_page.dart';
import 'package:partytime/pages/question_game.dart';
import 'package:partytime/pages/score_page.dart';
import 'package:partytime/pages/score_page_never.dart';
import 'package:partytime/pages/settings_page.dart';
import 'package:partytime/pages/start_page.dart';
import 'package:partytime/pages/welcome_page.dart';

class AppRoutes {
  static final routes = {
    welcome: (context) => WelcomePage(),
    start: (context) => StartPage(),
    games: (context) => GamesPage(),
    login: (context) => LoginPage(),
    settings: (context) => SettingsPage(),
    players: (context) => PlayersPage(),
    challange: (context) => ChallangePage(),
    level: (context) => LevelPage(),
    question: (context) => QuestionGame(),
    never: (context) => NeverGame(),
    score: (context) => ScorePage(),
    mix: (context) => MixPage(),
    scoreNever: (context) => ScorePageNever(),
  };

  static const welcome = "/";
  static const start = "/start";
  static const games = "/games";
  static const login = "/login";
  static const settings = "/settings";
  static const players = "/players";
  static const challange = "/challange";
  static const level = "/level";
  static const question = "/question";
  static const never = "/never";
  static const score = "/score";
  static const mix = "/mix";
  static const scoreNever = "/scoreNever";
}
