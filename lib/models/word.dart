// 英単語
class Word {
  String id;
  String english;
  String japanese;
  String englishExampleSentence;
  String japaneseExampleSentence;
  String remarks;
  String wordClass;

  Word();

  // コンストラクタ（Firestoreのデータからインスタンス化）
  Word.fromMap(String id, Map<String, dynamic> map) {
    this.id = id;
    this.english = map['english'];
    this.japanese = map['japanese'];
    this.englishExampleSentence = map['englishExampleSentence'];
    this.japaneseExampleSentence = map['japaneseExampleSentence'];
    this.remarks = map['remarks'];
    this.wordClass = map['class'];
  }

  // Firestoreのデータに変換
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['english'] = english;
    map['japanese'] = japanese;
    map['englishExampleSentence'] = englishExampleSentence;
    map['japaneseExampleSentence'] = japaneseExampleSentence;
    map['remarks'] = remarks;
    map['class'] = wordClass;

    return map;
  }
}
