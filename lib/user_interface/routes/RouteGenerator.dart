

import 'package:collective_project/user_interface/pages/HomePage.dart';
import 'package:collective_project/user_interface/pages/SettingsPage.dart';
import 'package:flutter/material.dart';

import '../pages/LoginPage.dart';
import '../pages/RegistrationPage.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case '/':
        return CustomPageRoute(
          builder: (context) => const LoginPage(),
        );
      case '/registration':
        return CustomPageRoute(
          builder: (context) => const RegistrationPage(),
        );
      case '/home/settings':
        return CustomPageRoute(
          builder: (context) => SettingsPage(),
        );
      case '/home':
        return CustomPageRoute(
          builder: (context) => const Home(),
        );
      default:
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute() {
    return CustomPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR IN NAVIGATION'),
        ),
      );
    });
  }
}

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}