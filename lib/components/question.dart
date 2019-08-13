import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';

class Question extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionsModel>(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(25),
      child: Text(
        question.currentQuestion,
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
