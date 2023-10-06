import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'dart:async';

// An enumeration representing different states of the Text-to-Speech (TTS) system
enum TtsState { playing, stopped, paused, continued }

// This class serves as a ChangeNotifier, which allows it to notify its listeners
class TtsPlayState with ChangeNotifier {
  // Initialize necessary properties for TTS
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 1.0;
  double pitch = 1.0;
  double rate = 0.55;
  bool isCurrentLanguageInstalled = false;
  TtsState ttsState = TtsState.stopped;

  // Getters to check the current state of TTS
  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  // Getters to determine the platform (iOS, Android, Windows, Web)
  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  // Constructor: Initialize FlutterTts and set some options
  TtsPlayState() {
    flutterTts = FlutterTts();
    _setAwaitOptions();
  }

  // Set an option to await speech completion
  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  // Function to initiate text-to-speech
  Future speak(voiceText) async {
    debugPrint(voiceText);

    // Configure TTS settings based on the platform
    if (isWeb){
      await flutterTts.setLanguage("");
      await flutterTts.setSpeechRate(1.0);
    } else {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setSpeechRate(rate);
    }

    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);

    // Check if voiceText is not empty and speak it
    if (voiceText != null) {
      if (voiceText!.isNotEmpty) {
        await flutterTts.speak(voiceText!);
      }
    }
  }
}
