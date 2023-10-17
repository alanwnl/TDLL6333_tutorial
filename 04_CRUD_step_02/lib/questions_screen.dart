import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appstate.dart';
import 'flashcard_screen.dart';
import 'mcq_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Questions"),
        // Temporary remove Back Button on AppBar
        // Need to remove this later
        automaticallyImplyLeading: false,
      ),
      //Check to see if the question in AppState is not empty
      body: appState.questions.isNotEmpty
          ? SafeArea(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: appState.questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(appState.questions[index].question),
                      onTap: () {
                        // When a ListTile is tapped, navigate to the FlashcardScreen and pass the
                        // currentQuestion from the appState to the new screen.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FlashcardScreen(
                                currentQuestion: appState.questions[index]),
                            // Pass the current question.
                          ),
                        );
                      },
                    );
                  }))
          //If it is empty, display a message
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'No questions available for this topic.',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
      //FloatingActionButton
      floatingActionButton: appState.questions.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MCQScreen(),
                  ),
                );
              },
              label: const Text('Start MCQ'),
              icon: const Icon(Icons.play_arrow),
              backgroundColor: Colors.blue,
            )
          : null,
    );
  }
}
