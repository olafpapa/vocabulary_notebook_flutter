import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';
import 'package:vocabulary_notebook_flutter/components/question.dart';
import 'package:vocabulary_notebook_flutter/components/answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;

  Quiz({
    @required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionIndexModel>(builder: (context, question, _) {
      return Column(
        children: [
          Question(questions[question.questionIndex]['questionText']),
          ...(questions[question.questionIndex]['answers'] as List<String>)
              .map((answer) {
            return Answer(answer);
          }).toList()
        ],
      );
    });
  }
}
