import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:provider/provider.dart';
import 'package:vocabulary_notebook_flutter/models/question.dart';

class ResultList extends StatefulWidget {
  @override
  _ResultListState createState() => _ResultListState();
}

enum TtsState { playing, stopped }

class _ResultListState extends State<ResultList> {
  FlutterTts flutterTts;
  dynamic languages;
  dynamic voices;
  String language;
  String voice;
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    if (Platform.isAndroid) {
      flutterTts.ttsInitHandler(() {
        _getLanguages();
        _getVoices();
      });
    } else if (Platform.isIOS) {
      _getLanguages();
      _getVoices();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    print(languages);
    if (languages != null) setState(() => languages);
  }

  Future _getVoices() async {
    voices = await flutterTts.getVoices;
    print(voices);
    if (voices != null) setState(() => voices);
  }

  Future _speak(String text) async {
    var result = await flutterTts.speak(text);
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionsModel>(context);

    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: question.numberOfQuestions,
      itemBuilder: (context, int index) {
        return Card(
          color: question.isCorrectAnswerAt(index)
              ? Colors.green[100]
              : Colors.red[100],
          child: InkWell(
            onTap: () {
              if (isStopped) {
                _speak(question.wordAt(index).englishExampleSentence);
              } else {
                _stop();
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    question.wordAt(index).englishWord,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    question.wordAt(index).japaneseWord,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black38,
                        width: 0.2,
                      ),
                    ),
                  ),
                  child: Text(
                    question.wordAt(index).englishExampleSentence,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Text(
                    question.wordAt(index).japaneseExampleSentence,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
