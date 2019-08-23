import 'package:flutter/material.dart';
import 'package:vocabulary_notebook_flutter/models/word.dart';
import 'package:vocabulary_notebook_flutter/service/tts_service.dart';

class WordCard extends StatelessWidget {
  final Word word;
  final Color color;

  WordCard(this.word, this.color);

  @override
  Widget build(BuildContext context) {
    final tts = TtsService();

    return Card(
      color: color,
      child: InkWell(
        onTap: () {
          if (tts.isStopped) {
            tts.speak(word.englishExampleSentence);
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
              child: Row(
                children: <Widget>[
                  word.wordClass != null
                      ? Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(1.0),
                          decoration: new BoxDecoration(
                            border: new Border.all(color: Colors.black38),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Text(
                            word.wordClass[0],
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                      : SizedBox.shrink(),
                  Container(
                    padding: word.wordClass != null
                        ? EdgeInsets.only(left: 10)
                        : EdgeInsets.all(0),
                    child: Text(
                      word.english,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Text(
                word.japanese,
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
                word.englishExampleSentence,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                word.japaneseExampleSentence,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
