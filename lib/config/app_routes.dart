import 'package:partytime/pages/challange_page.dart';
import 'package:partytime/pages/games_page.dart';
import 'package:partytime/pages/login_page.dart';
import 'package:partytime/pages/players_page.dart';
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
  };

  static const welcome = "/";
  static const start = "/start";
  static const games = "/games";
  static const login = "/login";
  static const settings = "/settings";
  static const players = "/players";
  static const challange = "/challange";
}
