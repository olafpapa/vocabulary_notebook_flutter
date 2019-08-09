import 'package:flutter/material.dart';

class Notebook {}

enum WordClass {
  noun, // 名詞
  prenoun, // 代名詞
  verb, // 動詞
  transitiveVerb, // 他動詞
  intransitiveVerb, // 自動詞
  adjective, // 形容詞
  adverbm, //副詞
  preposition, // 前置詞
  conjunction, // 接続詞
  others, // その他
}

class Word {
  final String id;
  final String englishWord;
  final String englishVoiceUrl;
  final String japaneseWord;
  final String englishExampleSentence;
  final String japaneseExampleSentence;
  final String remarks;
  final WordClass wordClass;

  Word(
      {this.id,
      this.englishWord,
      this.englishVoiceUrl,
      this.japaneseWord,
      this.englishExampleSentence,
      this.japaneseExampleSentence,
      this.remarks,
      this.wordClass});
}
