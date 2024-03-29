import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/components/result_list.dart';
import 'package:vocabulary_notebook_flutter/models/question_model.dart';
import 'package:vocabulary_notebook_flutter/models/questions_model.dart';
import 'package:vocabulary_notebook_flutter/components/quiz_view.dart';
import 'package:vocabulary_notebook_flutter/models/word.dart';

class QuestionScreen extends StatelessWidget {
  final List<Word> words;

  QuestionScreen(this.words);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => QuestionsModel(QuestionType.en2jp, words),
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
            ? QuizView()
            : ResultList(),
        floatingActionButton: Visibility(
          visible: question.questionIndex < question.numberOfQuestions,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.blue.withAlpha(180),
            onPressed: () => question.nextIndex(),
            label: question.isLastQuestion() ? Text('結果') : Text('次へ'),
          ),
        ),
      );
    });
  }
}
