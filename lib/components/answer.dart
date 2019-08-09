import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';

class Answer extends StatelessWidget {
  final String answerText;
  Answer(this.answerText);

  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionsModel>(context);

    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: question.isCorrectAnswer(answerText)
            ? Colors.redAccent
            : Colors.blueGrey,
        textColor: Colors.white,
        child: Text(answerText),
        onPressed: () {
          question.selectAnswer(answerText);
          Future.delayed(
              const Duration(seconds: 2), () => question.nextIndex());
        },
      ),
    );
  }
}
