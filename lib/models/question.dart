import 'package:flutter/widgets.dart';

class QuestionModel with ChangeNotifier {
  int _questionIndex = 0;

  var _questions = [
    {
      'question': '統合する',
      'answers': ['release', 'stairway', 'consolidate', 'attendant'],
      'correctAnswer': 'consolidate',
      'selectedAnswer': null,
      'result': null,
    },
    {
      'question': '配管工事',
      'answers': ['purchase', 'ignore', 'vary', 'plumbing'],
      'correctAnswer': 'plumbing',
      'selectedAnswer': null,
      'result': null,
    },
    {
      'question': '（販売促進用の）無料の景品',
      'answers': ['distinguished', 'consolidate', 'engaging', 'giveaway'],
      'correctAnswer': 'giveaway',
      'selectedAnswer': null,
      'result': null,
    },
    {
      'question': '水道水',
      'answers': ['tap water', 'clean water', 'mad water', 'sap water'],
      'correctAnswer': 'tap water',
      'selectedAnswer': null,
      'result': null,
    },
  ];

  int get questionIndex => _questionIndex;

  String get currentQuestion => _questions[_questionIndex]['question'];

  List<String> get currentAnswers => _questions[_questionIndex]['answers'];

  int get numberOfQuestions => _questions.length;

  bool isCorrectAnswer(String answerText) {
    final selectedAnswer = _questions[_questionIndex]['selectedAnswer'];
    final correctAnswer = _questions[_questionIndex]['correctAnswer'];
    return selectedAnswer != null && answerText == correctAnswer;
  }

  void nextIndex() {
    _questionIndex++;
    notifyListeners();
  }

  void reset() {
    _questionIndex = 0;
    _questions.forEach((question) {
      question['selectedAnswer'] = null;
    });
    notifyListeners();
  }

  void selectAnswer(String answerText) {
    _questions[_questionIndex]['selectedAnswer'] = answerText;
    _questions[_questionIndex]['result'] = isCorrectAnswer(answerText);
    notifyListeners();
  }
}
