import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/question_model.dart';
import 'package:vocabulary_notebook_flutter/models/questions_model.dart';
import 'package:vocabulary_notebook_flutter/models/word.dart';

class AnswerButton extends StatefulWidget {
  final Word word;
  const AnswerButton(this.word) : super();

  @override
  AnswerButtonState createState() => new AnswerButtonState();
}

class AnswerButtonState extends State<AnswerButton>
    with SingleTickerProviderStateMixin {
  Animation<Offset> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _animation = _animationController
        // https://api.flutter.dev/flutter/animation/CurveTween-class.html
        .drive(CurveTween(curve: Curves.elasticIn))
        // https://api.flutter.dev/flutter/animation/Tween-class.html
        .drive(Tween<Offset>(begin: Offset.zero, end: const Offset(0.05, 0)))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // アニメーション逆戻し
              _animationController.reverse();
            }
          });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionsModel>(context);
    final answerText = question.type == QuestionType.en2jp
        ? widget.word.japanese
        : widget.word.english;
    final translatedText = question.type == QuestionType.en2jp
        ? widget.word.english
        : widget.word.japanese;

    // https://api.flutter.dev/flutter/widgets/SlideTransition-class.html
    return SlideTransition(
      // Offset値が変化する
      position: _animation,
      child: Container(
        width: double.infinity,
        child: ButtonTheme(
          height: 64.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            color: question.isCorrectAnswer(answerText)
                ? Colors.green[300]
                : Colors.blueGrey,
            textColor: Colors.white,
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    answerText,
                    style: TextStyle(fontSize: 24),
                  ),
                  question.isSelectAnswer()
                      ? Text(
                          translatedText,
                          style: TextStyle(fontSize: 18),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            onPressed: () {
              if (!question.isSelectAnswer()) {
                if (question.correctAnswer != answerText) {
                  // アニメーションスタート
                  _animationController.forward();
                }
                question.selectAnswer(answerText);
              }
            },
          ),
        ),
      ),
    );
  }
}
