import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';
import 'package:vocabulary_notebook_flutter/models/word.dart';
import 'package:vocabulary_notebook_flutter/components/question.dart';
import 'package:vocabulary_notebook_flutter/components/answer.dart';

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionsModel>(builder: (context, question, _) {
      return Column(
        children: [
          Question(),
          ...(question.currentAnswers).map((Word answer) {
            return Answer(answer);
          }).toList()
        ],
      );
    });
  }
}
