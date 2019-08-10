import 'package:flutter/material.dart';
import 'package:vocabulary_notebook_flutter/models/word.dart';

class Sentence extends StatelessWidget {
  final Word word;
  Sentence(this.word);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Text(
              word.englishExampleSentence,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              word.japaneseExampleSentence,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
