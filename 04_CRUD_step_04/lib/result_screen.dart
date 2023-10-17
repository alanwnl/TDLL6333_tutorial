import 'package:flutter/material.dart';
import 'package:my_app/questions_screen.dart';
import 'package:my_app/topics_screen.dart';
import 'package:provider/provider.dart';

import 'appstate.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "You got ${appState.currectCounter} out of ${appState.questions.length.toString()} correct!",
                  textScaleFactor: 1.5),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  appState.resetQuiz();
                  //Change this from routing to MCQScreen
                  //Updated it to the newly created QuestionScreen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const TopicsScreen()),
                  );
                },
                child: const Text('Main', textScaleFactor: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
