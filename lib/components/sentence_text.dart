import 'package:flutter/material.dart';
import 'package:vocabulary_notebook_flutter/models/word.dart';

class SentenceText extends StatelessWidget {
  final Word word;
  SentenceText(this.word);

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
