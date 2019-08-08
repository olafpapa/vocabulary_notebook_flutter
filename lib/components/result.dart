import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionIndexModel>(context);

    return Center(
      child: Column(
        children: <Widget>[
          Text(
            '終わり',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          FlatButton(
            child: Text('Restart!'),
            onPressed: () => question.resetIndex(),
            textColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
