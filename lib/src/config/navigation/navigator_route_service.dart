import 'dart:io';

import 'package:fk_haber/src/config/constants/route_constants.dart';
import 'package:fk_haber/src/ui/auth/forgot_password_page.dart';
import 'package:fk_haber/src/ui/auth/login_page.dart';
import 'package:fk_haber/src/ui/auth/register_page.dart';
import 'package:fk_haber/src/ui/settings_page.dart';
import 'package:fk_haber/src/ui/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationRouteManager {
  static Route<dynamic> onRouteGenerate(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case k_ROUTE_SPLASH:
        return _navigateToDefault(SplashPage(), settings);
      case k_ROUTE_LOGIN:
        return _navigateToDefault(LoginPage(context: args), settings);
      case k_ROUTE_FORGOT_PASSWORD:
        return _navigateToDefault(ForgotPasswordPage(context: args), settings);
      case k_ROUTE_REGISTER:
        return _navigateToDefault(RegisterPage(), settings);
      case k_ROUTE_SETTINGS:
        return _navigateToDefault(SettingsPage(), settings);
    }
  }

  NavigationRouteManager._init();

  static _navigateToDefault(Widget page, RouteSettings settings) {
    if (Platform.isIOS)
      return CupertinoPageRoute(builder: (context) => page, settings: settings);
    else
      return MaterialPageRoute(builder: (context) => page, settings: settings);
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error Route'),
        ),
        body: Center(
          child: Text('Route cannot find.'),
        ),
      );
    });
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Unknown Route'),
        ),
        body: Center(
          child: Text('Route unknown.'),
        ),
      );
    });
  }
}
