import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elred_test/arguments.dart';
import 'package:elred_test/enums.dart';
import 'package:elred_test/screens/note.dart';
import 'package:elred_test/screens/home/home.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart" show Firebase;
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';

import 'service/app_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialWidget());
}

class MaterialWidget extends StatefulWidget {
  const MaterialWidget({Key? key}) : super(key: key);

  @override
  State<MaterialWidget> createState() => _MaterialWidgetState();
}

class _MaterialWidgetState extends State<MaterialWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: GoogleFonts.notoSerif().fontFamily),
        darkTheme: ThemeData(fontFamily: GoogleFonts.notoSerif().fontFamily),
        navigatorKey: navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case Home.route:
              return MaterialPageRoute(
                  builder: (context) =>
                      Home(arguments: settings.arguments as HomeArguments));
            case Note.route:
              return MaterialPageRoute(
                  builder: (context) => Note(
                      createNoteArguments:
                          settings.arguments as NoteArguments));
          }
        },
        home: const SignInDemo());
  }
}

class SignInDemo extends StatefulWidget {
  const SignInDemo({Key? key}) : super(key: key);

  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppService.googleSignIn.onCurrentUserChanged
          .listen((GoogleSignInAccount? account) {
        AppService.navigateTo(
            Home.route,
            HomeArguments(
                navigation: NAVIGATION.pushReplacement,
                googleSignInAccount: account!));
      });
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await AppService.googleSignIn.signIn();
    } catch (error) {}
  }

  Future<void> _handleSignOut() => AppService.googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: _handleSignIn,
            child: const Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      )),
    );
  }
}
