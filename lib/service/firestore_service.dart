import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService _instance = new FirestoreService._internal();
  factory FirestoreService() => _instance;
  FirestoreService._internal();

  Stream<QuerySnapshot> getNoteList() {
    final CollectionReference noteCollection =
        Firestore.instance.collection('notebook');

    return noteCollection.snapshots();
  }
}
