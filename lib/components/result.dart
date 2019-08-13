import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionsModel>(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(
            '${question.numberOfQuestions}問中 ${question.numberOfRightAnswers}問正解',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            '正答率 ${(question.numberOfRightAnswers / question.numberOfQuestions).round()}％',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          FlatButton(
            child: Text('Restart!'),
            onPressed: () => question.reset(),
            textColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
