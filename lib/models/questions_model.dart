import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:vocabulary_notebook_flutter/models/question_model.dart';
import 'package:vocabulary_notebook_flutter/models/word.dart';

class QuestionsModel with ChangeNotifier {
  final QuestionType type;
  final List<Word> words;
  List<QuestionModel> questions;
  int questionIndex = 0;

  // コンストラクタ
  QuestionsModel(this.type, this.words, {int numberOfQuestions = 10}) {
    // ランダムに問題を選ぶ
    List<Word> randomWords = [];
    while (randomWords.length < numberOfQuestions) {
      final rand = new Random();
      final n = rand.nextInt(words.length);
      if (randomWords.contains(words[n])) {
        continue;
      }
      randomWords.add(words[n]);
    }

    questions = randomWords
        .asMap()
        .map((index, word) =>
            MapEntry(index, QuestionModel(type, word, _makeAnswers(index, 3))))
        .values
        .toList();
  }

  // 選択肢を作成する
  List<Word> _makeAnswers(int index, int numberOfIncorrectAnswers) {
    // 正解のindex以外からランダムなindexを作成する
    if (numberOfIncorrectAnswers + 1 > words.length) {
      return [];
    }
    final rand = new Random();
    var indexArray = [];
    while (indexArray.length < numberOfIncorrectAnswers) {
      var n = rand.nextInt(words.length);
      if (n != index && !indexArray.contains(n)) {
        indexArray.add(n);
      }
    }
    // 正解のIndexを追加
    indexArray.add(index);

    // 選択肢をシャッフル
    indexArray.shuffle();

    return indexArray.map((index) {
      return words[index];
    }).toList();
  }

  String get currentQuestion => questions[questionIndex].question;

  String get correctAnswer => questions[questionIndex].correctAnswer;

  int get numberOfQuestions => questions.length;

  int get numberOfRightAnswers =>
      questions.where((q) => q.result == true).toList().length;

  List<Word> get currentAnswers => questions[questionIndex].answers;

  Word get correctWord => questions[questionIndex].word;

  Word wordAt(int index) => questions[index].word;

  bool isCorrectAnswerAt(int index) => questions[index].result == true;

  bool isCorrectAnswer(String answerText) {
    final selectedAnswer = questions[questionIndex].selectedAnswer;
    final correctAnswer = questions[questionIndex].correctAnswer;
    return selectedAnswer != null && answerText == correctAnswer;
  }

  bool isSelectAnswer() => questions[questionIndex].selectedAnswer != null;

  bool isLastQuestion() => questions.length - 1 == questionIndex;

  void nextIndex() {
    questionIndex++;
    notifyListeners();
  }

  void reset() {
    questionIndex = 0;
    questions.forEach((question) {
      question.selectedAnswer = null;
      question.result = null;
    });
    notifyListeners();
  }

  void selectAnswer(String answerText) {
    questions[questionIndex].selectedAnswer = answerText;
    questions[questionIndex].result = isCorrectAnswer(answerText);
    notifyListeners();
  }
}
