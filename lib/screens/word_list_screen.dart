import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vocabulary_notebook_flutter/models/word.dart';
import 'package:vocabulary_notebook_flutter/screens/question_screen.dart';
import 'package:vocabulary_notebook_flutter/service/firestore_service.dart';
import 'package:vocabulary_notebook_flutter/service/tts_service.dart';

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
    var tts = TtsService();

    return Scaffold(
      appBar: AppBar(title: Text('単語一覧')),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: items.length,
        itemBuilder: (context, int index) {
          return Card(
            color: Colors.grey[100],
            child: InkWell(
              onTap: () {
                if (tts.isStopped) {
                  tts.speak(items[index].englishExampleSentence);
                } else {
                  tts.stop();
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Text(
                      items[index].english,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      items[index].japanese,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.black38,
                          width: 0.2,
                        ),
                      ),
                    ),
                    child: Text(
                      items[index].englishExampleSentence,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Text(
                      items[index].japaneseExampleSentence,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuestionScreen(),
            ),
          );
        },
        label: Text("テスト開始"),
      ),
    );
  }
}
