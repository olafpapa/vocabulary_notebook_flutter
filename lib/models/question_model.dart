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
