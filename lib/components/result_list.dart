import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/components/word_card.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';

class ResultList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionsModel>(context);

    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: question.numberOfQuestions,
      itemBuilder: (context, int index) {
        return WordCard(
            question.wordAt(index),
            question.isCorrectAnswerAt(index)
                ? Colors.green[100]
                : Colors.red[100]);
      },
    );
  }
}
