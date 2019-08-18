import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';
import 'package:vocabulary_notebook_flutter/service/tts_service.dart';

class ResultList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionsModel>(context);
    var tts = TtsService();

    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: question.numberOfQuestions,
      itemBuilder: (context, int index) {
        return Card(
          color: question.isCorrectAnswerAt(index)
              ? Colors.green[100]
              : Colors.red[100],
          child: InkWell(
            onTap: () {
              if (tts.isStopped) {
                tts.speak(question.wordAt(index).englishExampleSentence);
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
                    question.wordAt(index).english,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    question.wordAt(index).japanese,
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
                    question.wordAt(index).englishExampleSentence,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Text(
                    question.wordAt(index).japaneseExampleSentence,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
