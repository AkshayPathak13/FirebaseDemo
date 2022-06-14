import 'package:elred_test/arguments.dart';
import 'package:elred_test/screens/home/login.dart';
import 'package:elred_test/screens/note.dart';
import 'package:elred_test/screens/home/home.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart" show Firebase;
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

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
        initialRoute: Login.route,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case Login.route:
              return MaterialPageRoute(builder: (context) => const Login());
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
        });
  }
}
