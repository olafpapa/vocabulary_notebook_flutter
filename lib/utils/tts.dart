import 'dart:io';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped }

class Tts {
  static Tts _instance;
  factory Tts() {
    _instance ??= Tts._internalConstructor();
    return _instance;
  }
  Tts._internalConstructor();

  FlutterTts flutterTts;
  dynamic languages;
  dynamic voices;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  _initTts() {
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
      ttsState = TtsState.playing;
    });

    flutterTts.setCompletionHandler(() {
      ttsState = TtsState.stopped;
    });

    flutterTts.setErrorHandler((msg) {
      ttsState = TtsState.stopped;
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
  }

  Future _getVoices() async {
    voices = await flutterTts.getVoices;
  }

  Future speak(String text) async {
    if (flutterTts == null) _initTts();

    var result = await flutterTts.speak(text);
    if (result == 1) ttsState = TtsState.playing;
  }

  Future stop() async {
    if (flutterTts == null) _initTts();

    var result = await flutterTts.stop();
    if (result == 1) ttsState = TtsState.stopped;
  }
}
