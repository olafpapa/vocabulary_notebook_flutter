import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/components/sentence_text.dart';
import 'package:vocabulary_notebook_flutter/models/questions_model.dart';
import 'package:vocabulary_notebook_flutter/models/word.dart';
import 'package:vocabulary_notebook_flutter/components/question_text.dart';
import 'package:vocabulary_notebook_flutter/components/answer_button.dart';

class QuizView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionsModel>(builder: (context, question, _) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              QuestionTexT(),
              ...(question.currentAnswers).map((Word answer) {
                return Column(
                  children: <Widget>[
                    AnswerButton(answer),
                    SizedBox(
                      width: double.infinity,
                      height: 25,
                    )
                  ],
                );
              }).toList(),
              question.isSelectAnswer()
                  ? SentenceText(question.correctWord)
                  : SizedBox.shrink(),
            ],
          ),
        ),
      );
    });
  }
}
