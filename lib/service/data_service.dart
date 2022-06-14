import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elred_test/models/note_model.dart';

class DataService {
  late final CollectionReference<Map<String, dynamic>> _collectionReference;
  DataService(String id) {
    _collectionReference = FirebaseFirestore.instance.collection(id);
  }

  String createNoteDocumentId() => _collectionReference.doc().id;

  Future<bool> addNote(NoteModel noteModel) {
    Completer<bool> completer = Completer();
    _collectionReference
        .doc(noteModel.id)
        .set(noteModel.toJson())
        .then((value) {
      completer.complete(true);
    }).catchError((error) {
      completer.complete(false);
    });
    return completer.future;
  }

  Future<bool> deleteNote(String docId) {
    Completer<bool> completer = Completer();
    var doc = _collectionReference.doc(docId);
    doc.delete().then((value) {
      completer.complete(true);
    }).catchError((error) {
      completer.complete(false);
    });
    return completer.future;
  }

  Future<bool> updateNote(NoteModel noteModel) {
    Completer<bool> completer = Completer();
    var doc = _collectionReference.doc(noteModel.id);
    doc.update(noteModel.toJson()).then((value) {
      completer.complete(true);
    }).catchError((error) {
      completer.complete(false);
    });
    return completer.future;
  }

  Stream<List<NoteModel>> getNotes() {
    return _collectionReference.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => NoteModel.fromJson(doc.data())).toList());
  }
}
