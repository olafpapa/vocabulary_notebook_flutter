import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';
import 'package:vocabulary_notebook_flutter/models/word.dart';

class Answer extends StatelessWidget {
  final Word word;
  Answer(this.word);

  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionsModel>(context);
    final answerText = question.type == QuestionType.en2jp
        ? word.japaneseWord
        : word.englishWord;
    final translatedText = question.type == QuestionType.en2jp
        ? word.englishWord
        : word.japaneseWord;
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: question.isCorrectAnswer(answerText)
            ? Colors.redAccent
            : Colors.blueGrey,
        textColor: Colors.white,
        child: Text(answerText +
            (question.isSelectAnswer(answerText) ? '\n$translatedText' : '')),
        onPressed: () {
          question.selectAnswer(answerText);
          Future.delayed(
              const Duration(seconds: 2), () => question.nextIndex());
        },
      ),
    );
  }
}
