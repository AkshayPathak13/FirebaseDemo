import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elred_test/arguments.dart';
import 'package:elred_test/screens/home/home.dart';
import 'package:elred_test/screens/home/login.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../enums.dart';
import 'data_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppService {
  static final AppService _instance = AppService._internal();
  static DataService? _dataService;
  static DataService? get dataService => _dataService;
  AppService._internal();
  factory AppService() {
    return _instance;
  }
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  static Future<bool> login() {
    Completer<bool> completer = Completer();
    googleSignIn.signIn().then((value) {
      _dataService = DataService(value!.id);
      completer.complete(true);
    }).catchError((error) {
      completer.complete(false);
    });
    return completer.future;
  }

  static void logout() {
    googleSignIn.signOut().then((value) {
      navigateTo(Login.route,
          arguments: Arguments(navigation: NAVIGATION.pushReplacement));
    });
  }

  static void navigateTo(String routeName, {Arguments? arguments}) {
    if (navigatorKey.currentState != null) {
      switch (arguments?.navigation) {
        case NAVIGATION.push:
          navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
          break;
        case NAVIGATION.pushReplacement:
          navigatorKey.currentState!
              .pushReplacementNamed(routeName, arguments: arguments);
          break;
        case null:
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
