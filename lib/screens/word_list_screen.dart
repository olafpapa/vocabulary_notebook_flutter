import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vocabulary_notebook_flutter/components/word_card.dart';
import 'package:vocabulary_notebook_flutter/models/word.dart';
import 'package:vocabulary_notebook_flutter/screens/question_screen.dart';
import 'package:vocabulary_notebook_flutter/service/firestore_service.dart';

class WordListScreen extends StatefulWidget {
  final String notebookId;
  WordListScreen(this.notebookId);

  @override
  _WordListScreenState createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  List<Word> items = [];
  FirestoreService db = FirestoreService();
  StreamSubscription<QuerySnapshot> subscription;

  @override
  void initState() {
    super.initState();

    subscription?.cancel();
    subscription =
        db.getWordList(widget.notebookId).listen((QuerySnapshot snapshot) {
      final List<Word> words = snapshot.documents
          .map((documentSnapshot) =>
              Word.fromMap(documentSnapshot.documentID, documentSnapshot.data))
          .toList();

      setState(() {
        this.items = words;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('単語一覧')),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: items.length,
        itemBuilder: (context, int index) {
          return WordCard(items[index], Colors.grey[200]);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue.withAlpha(180),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuestionScreen(items),
            ),
          );
        },
        label: Text("テスト"),
      ),
    );
  }
}
