import 'package:flutter/cupertino.dart';

import './screens/splash/splash_screen.dart';
import './screens/home_page/home_page.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (_) => SplashScreen(),
  HomePage.routeName: (_) => HomePage(),
};
