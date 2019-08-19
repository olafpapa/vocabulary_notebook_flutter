import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/components/result_list.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';
import 'package:vocabulary_notebook_flutter/components/quiz.dart';

class QuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => QuestionsModel(QuestionType.en2jp),
      child: QuestionView(),
    );
  }
}

class QuestionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionsModel>(builder: (context, question, _) {
      return Scaffold(
        appBar: AppBar(title: Text('問題')),
        body: question.questionIndex < question.numberOfQuestions
            ? Quiz()
            : ResultList(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => question.reset(),
          label: Text("リセット"),
          icon: Icon(Icons.redo),
        ),
      );
    });
  }
}
