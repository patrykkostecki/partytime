import 'package:partytime/pages/start_page.dart';
import 'package:partytime/pages/welcome_page.dart';

class AppRoutes {
  static final routes = {
    welcome: (context) => WelcomePage(),
    start: (context) => StartPage(),
  };

  static const welcome = "/";
  static const start = "/start";
}
