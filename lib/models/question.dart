import 'package:flutter/widgets.dart';

class QuestionIndexModel with ChangeNotifier {
  int _questionIndex = 0;

  int get questionIndex => _questionIndex;

  void nextIndex() {
    _questionIndex++;
    notifyListeners();
  }

  void resetIndex() {
    _questionIndex = 0;
    notifyListeners();
  }
}
