import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService _instance = new FirestoreService._internal();
  factory FirestoreService() => _instance;
  FirestoreService._internal();

  // 単語帳を取得する
  Stream<QuerySnapshot> getNoteList() {
    final CollectionReference noteCollection =
        Firestore.instance.collection('notebook');

    return noteCollection.snapshots();
  }

  // 単語一覧を取得する
  Stream<QuerySnapshot> getWordList(String documentId) {
    final CollectionReference wordCollection = Firestore.instance
        .collection('notebook')
        .document(documentId)
        .collection('words');
    return wordCollection.snapshots();
  }
}
