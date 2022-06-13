import 'package:elred_test/arguments.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../enums.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppService {
  static final AppService _instance = AppService._internal();
  AppService._internal();
  factory AppService() {
    return _instance;
  }
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  static void navigateTo(String routeName, Arguments arguments) {
    if (navigatorKey.currentState != null) {
      switch (arguments.navigation) {
        case NAVIGATION.push:
          navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
          break;
        case NAVIGATION.pushReplacement:
          navigatorKey.currentState!
              .pushReplacementNamed(routeName, arguments: arguments);
          break;
      }
    }
  }

  static void pop({String? routeName}) {
    if (navigatorKey.currentState != null) {
      if (routeName != null) {
        navigatorKey.currentState!.popUntil((name) {
          return name.toString() == routeName;
        });
      } else {
        navigatorKey.currentState!.pop();
      }
    }
  }
}
