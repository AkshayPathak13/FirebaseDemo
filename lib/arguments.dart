import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elred_test/models/note_model.dart';
import 'package:elred_test/enums.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Arguments {
  final NAVIGATION navigation;
  Arguments({required this.navigation});
}

class HomeArguments extends Arguments {
  final GoogleSignInAccount googleSignInAccount;
  HomeArguments(
      {required this.googleSignInAccount, required NAVIGATION navigation})
      : super(navigation: navigation);
}

class NoteArguments extends Arguments {
  final CollectionReference<Map<String, dynamic>> collectionReference;
  final NoteModel noteModel;
  final NoteMode noteMode;
  NoteArguments(
      {required this.collectionReference,
      required this.noteModel,
      required this.noteMode,
      required NAVIGATION navigation})
      : super(navigation: navigation);
}
