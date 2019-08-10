import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/components/sentence.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';
import 'package:vocabulary_notebook_flutter/models/word.dart';
import 'package:vocabulary_notebook_flutter/components/question.dart';
import 'package:vocabulary_notebook_flutter/components/answer.dart';

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionsModel>(builder: (context, question, _) {
      return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Question(),
            ...(question.currentAnswers).map((Word answer) {
              return Column(
                children: <Widget>[
                  Answer(answer),
                  SizedBox(
                    width: double.infinity,
                    height: 25,
                  )
                ],
              );
            }).toList(),
            question.isSelectAnswer()
                ? Sentence(question.correctWord)
                : SizedBox.shrink(),
            question.isSelectAnswer()
                ? FlatButton(
                    child: question.isLastQuestion()
                        ? Text('結果を見る')
                        : Text('次の問題へ'),
                    onPressed: () => question.nextIndex(),
                    textColor: Colors.blue,
                  )
                : SizedBox.shrink(),
          ],
        ),
      );
    });
  }
}
