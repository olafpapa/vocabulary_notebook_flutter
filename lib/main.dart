import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';
import 'package:vocabulary_notebook_flutter/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _questions = const [
    {
      'questionText': '私の好きな食べ物は何でしょうか？',
      'answers': ['焼き肉', 'ごはん', 'さしみ', '漬物', '吉牛']
    },
    {
      'questionText': '私の好きな動物は何でしょうか？',
      'answers': ['ねこ', 'いぬ', 'さる', 'ライオン']
    },
    {
      'questionText': '私の好きな色は何でしょうか？',
      'answers': ['赤', '青', '黄色', '白', '黒']
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        builder: (context) => QuestionIndexModel(),
        child: MaterialApp(
          home: Home(_questions),
        ));
  }
}
