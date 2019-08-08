import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';
import 'package:vocabulary_notebook_flutter/components/result.dart';
import 'package:vocabulary_notebook_flutter/components/quiz.dart';

class Home extends StatelessWidget {
  final List<Map<String, Object>> questions;
  Home(this.questions);

  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionIndexModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('英単語帳')),
      body: question.questionIndex < questions.length
          ? Quiz(questions: questions)
          : Result(),
    );
  }
}
