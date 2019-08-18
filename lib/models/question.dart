import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:vocabulary_notebook_flutter/models/word.dart';

enum QuestionType {
  jp2en, // 和英
  en2jp, // 英和
}

class QuestionModel {
  // 和英・英和
  final QuestionType type;

  // 問題
  String question;

  // 答えの単語のList
  List<Word> answers;

  // 正解の単語
  Word word;

  // 正解
  String correctAnswer;

  // 選択した答え
  String selectedAnswer;

  // 正解かどうか
  bool result;

  QuestionModel(this.type, this.word, this.answers) {
    if (type == QuestionType.en2jp) {
      question = word.english;
      correctAnswer = word.japanese;
    } else {
      question = word.japanese;
      correctAnswer = word.english;
    }
  }
}

class QuestionsModel with ChangeNotifier {
  int _questionIndex = 0;
  QuestionType type;

  final sampleNotebook = [
    // Word(
    //   id: '1',
    //   englishWord: 'mean',
    //   wordClass: WordClass.transitiveVerb,
    //   japaneseWord: '〜を意図する',
    //   remarks: 'mean to do ~ (~することを意図する)',
    //   englishExampleSentence: 'I did\'t mean to hurt you.',
    //   japaneseExampleSentence: 'あなたを傷つけようと意図したのではない。',
    // ),
  ];

  // 選択肢を作成する
  List<Word> _makeAnswers(int index, int numberOfIncorrectAnswers) {
    // 正解のindex以外からランダムなindexを作成する
    if (numberOfIncorrectAnswers + 1 > sampleNotebook.length) {
      return [];
    }
    final rand = new Random();
    var indexArray = [];
    while (indexArray.length < numberOfIncorrectAnswers) {
      var n = rand.nextInt(sampleNotebook.length);
      if (n != index && !indexArray.contains(n)) {
        indexArray.add(n);
      }
    }
    // 正解のIndexを追加
    indexArray.add(index);

    // 選択肢をシャッフル
    indexArray.shuffle();

    return indexArray.map((index) {
      return sampleNotebook[index];
    }).toList();
  }

  List<QuestionModel> _questions;

  // コンストラクタ
  QuestionsModel(this.type) {
    _questions = []
        .map((index) =>
            QuestionModel(type, sampleNotebook[index], _makeAnswers(index, 3)))
        .toList();
  }

  int get questionIndex => _questionIndex;

  String get currentQuestion => _questions[_questionIndex].question;

  String get correctAnswer => _questions[_questionIndex].correctAnswer;

  int get numberOfQuestions => _questions.length;

  int get numberOfRightAnswers =>
      _questions.where((q) => q.result == true).toList().length;

  List<Word> get currentAnswers => _questions[_questionIndex].answers;

  Word get correctWord => _questions[_questionIndex].word;

  Word wordAt(int index) => _questions[index].word;

  bool isCorrectAnswerAt(int index) => _questions[index].result == true;

  bool isCorrectAnswer(String answerText) {
    final selectedAnswer = _questions[_questionIndex].selectedAnswer;
    final correctAnswer = _questions[_questionIndex].correctAnswer;
    return selectedAnswer != null && answerText == correctAnswer;
  }

  bool isSelectAnswer() => _questions[_questionIndex].selectedAnswer != null;

  bool isLastQuestion() => _questions.length - 1 == _questionIndex;

  void nextIndex() {
    _questionIndex++;
    notifyListeners();
  }

  void reset() {
    _questionIndex = 0;
    _questions.forEach((question) {
      question.selectedAnswer = null;
      question.result = null;
    });
    notifyListeners();
  }

  void selectAnswer(String answerText) {
    _questions[_questionIndex].selectedAnswer = answerText;
    _questions[_questionIndex].result = isCorrectAnswer(answerText);
    notifyListeners();
  }
}
