import 'package:flutter/widgets.dart';

class QuestionModel with ChangeNotifier {
  int _questionIndex = 0;

  var _questions = [
    {
      'question': '統合する',
      'answers': ['release', 'stairway', 'consolidate', 'attendant'],
      'correctAnswer': 2,
      'selectedAnswer': null
    },
    {
      'question': '配管工事',
      'answers': ['purchase', 'ignore', 'vary', 'plumbing'],
      'correctAnswer': 3,
      'selectedAnswer': null
    },
    {
      'question': '（販売促進用の）無料の景品',
      'answers': ['distinguished', 'consolidate', 'engaging', 'giveaway'],
      'correctAnswer': 3,
      'selectedAnswer': null
    },
    {
      'question': '水道水',
      'answers': ['tap water', 'clean water', 'mad water', 'sap water'],
      'correctAnswer': 1,
      'selectedAnswer': null
    },
  ];

  int get questionIndex => _questionIndex;

  String get currentQuestion => _questions[_questionIndex]['question'];

  List<String> get currentAnswers => _questions[_questionIndex]['answers'];

  int get numberOfQuestions => _questions.length;

  void nextIndex() {
    _questionIndex++;
    notifyListeners();
  }

  void resetIndex() {
    _questionIndex = 0;
    notifyListeners();
  }

  void selectAnswer(String answerText) {
    final int index = (_questions[_questionIndex]['answers'] as List<String>)
        .indexOf(answerText);
    _questions[_questionIndex]['selectedAnswer'] = index;
  }
}
