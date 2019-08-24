import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/questions_model.dart';

class QuestionTexT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionsModel>(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: Text(
        question.currentQuestion,
        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
