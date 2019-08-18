import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vocabulary_notebook_flutter/models/notebook.dart';
import 'package:vocabulary_notebook_flutter/service/firestore_service.dart';

class NotebookScreen extends StatefulWidget {
  @override
  NotebookScreenState createState() => NotebookScreenState();
}

class NotebookScreenState extends State<NotebookScreen> {
  List<Notebook> items = [];
  FirestoreService db = FirestoreService();
  StreamSubscription<QuerySnapshot> noteSub;

  @override
  void initState() {
    super.initState();

    noteSub?.cancel();
    noteSub = db.getNoteList().listen((QuerySnapshot snapshot) {
      final List<Notebook> notes = snapshot.documents
          .map((documentSnapshot) => Notebook.fromMap(
              documentSnapshot.documentID, documentSnapshot.data))
          .toList();

      setState(() {
        this.items = notes;
      });
    });
  }

  @override
  void dispose() {
    noteSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('英単語帳')),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: items.length,
        itemBuilder: (context, int index) {
          return Card(
            child: InkWell(
              onTap: () {},
              child: ListTile(
                title: Text(items[index].title),
                subtitle: Text(items[index].updatedAt.toString()),
                trailing: Icon(Icons.more_vert),
              ),
            ),
          );
        },
      ),
    );
  }
}
