import 'package:flutter/widgets.dart';
import 'package:vocabulary_notebook_flutter/models/word.dart';
import 'dart:math';

enum QuestionType {
  jp2en, // 和英
  en2jp, // 英和
}

class QuestionModel {
  // 和英・英和
  final QuestionType type;

  // 問題
  String question;

  // 答えの単語の配列
  List<Word> answers;

  // 正解
  String correctAnswer;

  // 選択した答え
  String selectedAnswer;

  // 正解かどうか
  bool result;

  QuestionModel(this.type, Word word, this.answers) {
    if (type == QuestionType.en2jp) {
      question = word.englishWord;
      correctAnswer = word.japaneseWord;
    } else {
      question = word.japaneseWord;
      correctAnswer = word.englishWord;
    }
  }
}

class QuestionsModel with ChangeNotifier {
  int _questionIndex = 0;
  QuestionType type;

  final sampleNotebook = [
    Word(
      id: '1',
      englishWord: 'mean',
      wordClass: WordClass.transitiveVerb,
      japaneseWord: '〜を意図する',
      remarks: 'mean to do ~ (~することを意図する)',
      englishExampleSentence: 'I did\'t mean to hurt you.',
      japaneseExampleSentence: 'あなたを傷つけようと意図したのではない。',
      englishVoiceUrl: '',
    ),
    Word(
      id: '2',
      englishWord: 'seem',
      wordClass: WordClass.intransitiveVerb,
      japaneseWord: '〜のように見える',
      remarks: '',
      englishExampleSentence: 'She seems to be tired.',
      japaneseExampleSentence: '彼女は疲れているように見える。',
      englishVoiceUrl: '',
    ),
    Word(
      id: '3',
      englishWord: 'meet',
      wordClass: WordClass.transitiveVerb,
      japaneseWord: '〜と会う',
      remarks: '',
      englishExampleSentence: 'I met her on the train yesterday.',
      japaneseExampleSentence: '昨日彼女に電車で会った。',
      englishVoiceUrl: '',
    ),
    Word(
      id: '4',
      englishWord: 'increase',
      wordClass: WordClass.noun,
      japaneseWord: '増加',
      remarks: '',
      englishExampleSentence: 'Crime in big cities is on the increase.',
      japaneseExampleSentence: '大都市での犯罪は増加中だ。',
      englishVoiceUrl: '',
    ),
    Word(
      id: '5',
      englishWord: 'increase',
      wordClass: WordClass.intransitiveVerb,
      japaneseWord: '増加する',
      remarks: '',
      englishExampleSentence: 'His weight has increased by 5 kilograms.',
      japaneseExampleSentence: '彼の体重は5キロ増えた。',
      englishVoiceUrl: '',
    ),
    Word(
      id: '6',
      englishWord: 'author',
      wordClass: WordClass.noun,
      japaneseWord: '著者',
      remarks: '',
      englishExampleSentence: 'He was a popular author.',
      japaneseExampleSentence: '彼は有名な著者だった。',
      englishVoiceUrl: '',
    ),
    Word(
      id: '7',
      englishWord: 'decide',
      wordClass: WordClass.transitiveVerb,
      japaneseWord: '〜を決断する／決定する',
      remarks: '',
      englishExampleSentence: 'They decided to go abroad.',
      japaneseExampleSentence: '彼らは海外にいくと決断した。',
      englishVoiceUrl: '',
    ),
    Word(
      id: '8',
      englishWord: 'type',
      wordClass: WordClass.transitiveVerb,
      japaneseWord: '〜をタイプする',
      remarks: '',
      englishExampleSentence: 'How many words can you type a minite?',
      japaneseExampleSentence: '1分間に何文字タイプできますか？',
      englishVoiceUrl: '',
    ),
    Word(
      id: '9',
      englishWord: 'book',
      wordClass: WordClass.transitiveVerb,
      japaneseWord: '〜を予約する',
      remarks: '',
      englishExampleSentence:
          'I\'d like to book a flight from Tokyo to New York.',
      japaneseExampleSentence: 'ニューヨークから東京への便を予約したい。',
      englishVoiceUrl: '',
    ),
    Word(
      id: '10',
      englishWord: 'result',
      wordClass: WordClass.noun,
      japaneseWord: '結果',
      remarks: '',
      englishExampleSentence:
          'He workd too hard, with the result that he got sick.',
      japaneseExampleSentence: '彼は仕事を一生懸命しすぎて結果は病気になった。',
      englishVoiceUrl: '',
    ),
    Word(
      id: '11',
      englishWord: 'result',
      wordClass: WordClass.intransitiveVerb,
      japaneseWord: '〜から生じる',
      remarks: '',
      englishExampleSentence: 'His failure resulted from his laziness.',
      japaneseExampleSentence: '彼の失敗は怠惰から生じた。',
      englishVoiceUrl: '',
    ),
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
    _questions = [0, 1, 2]
        .map((index) =>
            QuestionModel(type, sampleNotebook[index], _makeAnswers(index, 3)))
        .toList();
  }

  int get questionIndex => _questionIndex;

  String get currentQuestion => _questions[_questionIndex].question;

  int get numberOfQuestions => _questions.length;

  List<String> currentAnswers() {
    return _questions[_questionIndex].answers.map((word) {
      return type == QuestionType.en2jp ? word.japaneseWord : word.englishWord;
    }).toList();
  }

  bool isCorrectAnswer(String answerText) {
    final selectedAnswer = _questions[_questionIndex].selectedAnswer;
    final correctAnswer = _questions[_questionIndex].correctAnswer;
    return selectedAnswer != null && answerText == correctAnswer;
  }

  void nextIndex() {
    _questionIndex++;
    notifyListeners();
  }

  void reset() {
    _questionIndex = 0;
    _questions.forEach((question) => question.selectedAnswer = null);
    notifyListeners();
  }

  void selectAnswer(String answerText) {
    _questions[_questionIndex].selectedAnswer = answerText;
    _questions[_questionIndex].result = isCorrectAnswer(answerText);
    notifyListeners();
  }
}
