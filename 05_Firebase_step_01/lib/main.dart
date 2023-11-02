import 'package:flutter/material.dart';
import 'package:my_app/questions_screen.dart';
import 'package:my_app/topics_screen.dart';
import 'package:my_app/tts_play_state.dart';
import 'package:provider/provider.dart';

import 'appstate.dart';
import 'mcq_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => TtsPlayState()),
      ],
      child: MCQApp(),
    ),
  );
}

class MCQApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCQ Question App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      //Change this from routing to MCQScreen
      //Updated it to the newly created QuestionScreen
      home: const TopicsScreen(),
    );
  }
}
