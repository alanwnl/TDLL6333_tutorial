import 'package:flutter/material.dart';
import 'package:my_app/question.dart';
import 'package:my_app/result_screen.dart';
import 'package:provider/provider.dart';

import 'appstate.dart';
import 'option_button_widget.dart';

class MCQScreen extends StatefulWidget {
  const MCQScreen({super.key});

  @override
  State<MCQScreen> createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    Question currentQuestion =
        appState.questions[appState.currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("MCQ"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                height: 120,
                width: double.infinity,
                color: Colors.greenAccent,
                child: Center(
                    child: Text(
                  currentQuestion.question,
                  textScaleFactor: 1.5,
                ))),
            Expanded(
                child: Container(
              color: Colors.amber,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        OptionButton(
                          text: currentQuestion.options[0],
                          isSelected: appState.selectedOptionIndex == 0,
                          onPressed: () {
                            print(
                                "Answer 0 clicked ${currentQuestion.options[0]}");
                            setState(() {
                              appState.selectedOptionIndex = 0;
                            });
                          },
                        ),
                        OptionButton(
                          text: currentQuestion.options[1],
                          isSelected: appState.selectedOptionIndex == 1,
                          onPressed: () {
                            print(
                                "Answer 0 clicked ${currentQuestion.options[1]}");
                            setState(() {
                              appState.selectedOptionIndex = 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        OptionButton(
                          text: currentQuestion.options[2],
                          isSelected: appState.selectedOptionIndex == 2,
                          onPressed: () {
                            print(
                                "Answer 0 clicked ${currentQuestion.options[2]}");
                            setState(() {
                              appState.selectedOptionIndex = 2;
                            });
                          },
                        ),
                        OptionButton(
                          text: currentQuestion.options[3],
                          isSelected: appState.selectedOptionIndex == 3,
                          onPressed: () {
                            print(
                                "Answer 0 clicked ${currentQuestion.options[3]}");
                            setState(() {
                              appState.selectedOptionIndex = 3;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
            Container(
                height: 80,
                width: double.infinity,
                color: Colors.greenAccent,
                child: ElevatedButton(
                  onPressed: appState.selectedOptionIndex == null
                      ? null
                      : () {
                          print(
                              "Correct answer index is: ${currentQuestion.correctAnswerIndex}");
                          showModalBottomSheet(
                              context: context,
                              isDismissible: false,
                              enableDrag: false,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 200,
                                  color: currentQuestion.correctAnswerIndex ==
                                          appState.selectedOptionIndex
                                      ? Colors.green
                                      : Colors.red,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        currentQuestion.correctAnswerIndex ==
                                                appState.selectedOptionIndex
                                            ? const Text('Correct',
                                                textScaleFactor: 1.5)
                                            : Text(
                                                'The correct answer is:${currentQuestion.options[currentQuestion.correctAnswerIndex]}',
                                                textScaleFactor: 1.5),
                                        ElevatedButton(
                                          child: const Text('Next Question'),
                                          onPressed: () {
                                            setState(() {
                                              appState.selectedOptionIndex =
                                                  null;
                                              if (appState
                                                      .currentQuestionIndex <
                                                  appState.questions.length -
                                                      1) {
                                                appState.currentQuestionIndex++;
                                                Navigator.pop(context);
                                              } else {
                                                appState.currentQuestionIndex =
                                                    0;
                                                Navigator.of(context)
                                                  ..pop()
                                                  ..push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const ResultScreen()),
                                                  );
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                  ),
                  child: const Text(
                    'Check',
                    textScaleFactor: 1.5,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
