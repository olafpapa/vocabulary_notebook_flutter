import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';

class Answer extends StatelessWidget {
  final String answerText;
  Answer(this.answerText);

  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionIndexModel>(context);

    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blueGrey,
        textColor: Colors.white,
        child: Text(answerText),
        onPressed: () => question.nextIndex(),
      ),
    );
  }
}
