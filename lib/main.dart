import 'package:flutter/material.dart';
import 'package:vocabulary_notebook_flutter/screens/notebook_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotebookScreen(),
    );
  }
}
