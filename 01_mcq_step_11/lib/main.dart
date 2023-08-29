import 'package:flutter/material.dart';
import 'result.dart';

import 'question.dart';

void main() => runApp(MCQApp());

class MCQApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCQ Question App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MCQScreen(),
    );
  }
}

class MCQScreen extends StatefulWidget {
  const MCQScreen({super.key});

  @override
  State<MCQScreen> createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  int? _selectedOptionIndex;
  int _currentQuestionIndex = 0;

  final List<Question> _questions = [
    Question(
      question: 'What is the capital of France?',
      options: ['Paris', 'London', 'Berlin', 'Rome'],
      correctAnswerIndex: 0,
    ),
    Question(
      question: 'Who painted the Mona Lisa?',
      options: [
        'Leonardo da Vinci',
        'Pablo Picasso',
        'Vincent van Gogh',
        'Michelangelo'
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      question: 'Which country is the Statue of Liberty located in?',
      options: ['France', 'United States', 'Italy', 'Greece'],
      correctAnswerIndex: 1,
    ),
    Question(
      question: 'What is the highest mountain in the world?',
      options: ['Mount Everest', 'K2', 'Lhotse', 'Kangchenjunga'],
      correctAnswerIndex: 0,
    ),
    Question(
      question: 'What is the name of the largest ocean in the world?',
      options: [
        'Pacific Ocean',
        'Atlantic Ocean',
        'Indian Ocean',
        'Arctic Ocean'
      ],
      correctAnswerIndex: 0,
    )
    // Add more questions here
  ];

  void _nextQuestion() {
    setState(() {
      _selectedOptionIndex = null;
      debugPrint("_currentQuestionIndex=$_currentQuestionIndex");
      debugPrint("_questions.length=${_questions.length}");
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        Navigator.pop(context);
      } else {
        _currentQuestionIndex = 0;
        Navigator.of(context)
          ..pop()
          ..push(
            MaterialPageRoute(builder: (context) => const ResultPage()),
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Step 08a
    Question currentQuestion = _questions[_currentQuestionIndex];

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
                //Step 08b
                child: Center(
                    child: Text(
                  currentQuestion.question,
                  textScaleFactor: 1.5,
                ))),
            Expanded(
                child: Container(
              color: Colors.amber,
              width: double.infinity,
              //Paste the step 05 code below
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: double.infinity,
                            child: ElevatedButton(
                              //Step 08d
                              onPressed: () {
                                print(
                                    "Answer 0 clicked ${currentQuestion.options[0]}");
                                setState(() {
                                  _selectedOptionIndex = 0;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _selectedOptionIndex == 0
                                    ? Colors.lightBlue[50]
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              //Step 08c
                              child: Text(
                                currentQuestion.options[0],
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                print(
                                    "Answer 1 clicked ${currentQuestion.options[1]}");
                                setState(() {
                                  _selectedOptionIndex = 1;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _selectedOptionIndex == 1
                                    ? Colors.lightBlue[50]
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              child: Text(
                                currentQuestion.options[1],
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                print(
                                    "Answer 2 clicked ${currentQuestion.options[2]}");
                                setState(() {
                                  _selectedOptionIndex = 2;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _selectedOptionIndex == 2
                                    ? Colors.lightBlue[50]
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              child: Text(
                                currentQuestion.options[2],
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                print(
                                    "Answer 3 clicked ${currentQuestion.options[3]}");
                                setState(() {
                                  _selectedOptionIndex = 3;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _selectedOptionIndex == 3
                                    ? Colors.lightBlue[50]
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              child: Text(
                                currentQuestion.options[3],
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ),
                        )
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
                  onPressed: _selectedOptionIndex == null
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
                                          _selectedOptionIndex
                                      ? Colors.green
                                      : Colors.red,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        currentQuestion.correctAnswerIndex ==
                                                _selectedOptionIndex
                                            ? const Text('Correct')
                                            : Text(
                                                'The correct answer is:${currentQuestion.options[currentQuestion.correctAnswerIndex]}'),
                                        ElevatedButton(
                                          child: const Text('Next Question'),
                                          onPressed: () {
                                            _nextQuestion();
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
