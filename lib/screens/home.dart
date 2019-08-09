import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';
import 'package:vocabulary_notebook_flutter/components/result.dart';
import 'package:vocabulary_notebook_flutter/components/quiz.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionsModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('英単語帳')),
      body: question.questionIndex < question.numberOfQuestions
          ? Quiz()
          : Result(),
    );
  }
}
