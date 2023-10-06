import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appstate.dart';
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
                      onTap: () {},
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
    );
  }
}
