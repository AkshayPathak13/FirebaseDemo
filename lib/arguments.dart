import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elred_test/models/note_model.dart';
import 'package:elred_test/enums.dart';

class Arguments {
  final NAVIGATION navigation;
  Arguments({required this.navigation});
}

class HomeArguments extends Arguments {
  HomeArguments({required NAVIGATION navigation})
      : super(navigation: navigation);
}

class NoteArguments extends Arguments {
  final NoteModel noteModel;
  final NoteMode noteMode;
  NoteArguments(
      {required this.noteModel,
      required this.noteMode,
      required NAVIGATION navigation})
      : super(navigation: navigation);
}
