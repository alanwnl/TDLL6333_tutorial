import 'package:flutter/material.dart';
import 'package:my_app/question.dart';
import 'package:my_app/tts_play_state.dart';
import 'package:provider/provider.dart';

class FlashcardScreen extends StatelessWidget {
  Question currentQuestion;

  // Constructor to initialize the currentQuestion property
  FlashcardScreen({required this.currentQuestion});

  @override
  Widget build(BuildContext context) {
    // Access the TtsPlayState using the Provider package
    var ttsWidgetState = context.watch<TtsPlayState>();

    return Scaffold(
      appBar: AppBar(
        // You can add an AppBar title here if needed
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              textDirection: TextDirection.ltr,
              children: [
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  onPressed: () {
                    // Speak the current question when the volume button is pressed
                    ttsWidgetState.speak(currentQuestion.question);
                  },
                ),
                Expanded(
                  child: Text(
                    currentQuestion.question,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Show Answer'),
                onPressed: () {
                  // Show an alert dialog with the correct answer when the button is pressed
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Answer'),
                      content: Text(currentQuestion.options[currentQuestion.correctAnswerIndex]),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.volume_up),
                          onPressed: () {
                            // Speak the correct answer when the volume button is pressed in the dialog
                            ttsWidgetState.speak(currentQuestion.options[currentQuestion.correctAnswerIndex]);
                          },
                        ),
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            // Close the dialog when the "OK" button is pressed
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
