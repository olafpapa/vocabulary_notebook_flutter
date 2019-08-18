import 'package:cloud_firestore/cloud_firestore.dart';

// 英単語帳
class Notebook {
  String id;
  String title;
  String tag;
  DateTime createdAt;
  DateTime updatedAt;

  Notebook();

  // コンストラクタ（Firestoreのデータからインスタンス化）
  Notebook.fromMap(String id, Map<String, dynamic> map) {
    this.id = id;
    this.title = map['title'];
    this.tag = map['tag'];
    final originCreatedAt = map['createdAt'];
    if (originCreatedAt is Timestamp) {
      this.createdAt = originCreatedAt.toDate();
    }
    final originUpdatedAt = map['updatedAt'];
    if (originUpdatedAt is Timestamp) {
      this.updatedAt = originUpdatedAt.toDate();
    }
  }

  // Firestoreのデータに変換
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['title'] = title;
    map['tag'] = tag;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;

    return map;
  }
}
