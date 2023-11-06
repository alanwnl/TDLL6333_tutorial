import 'package:flutter/material.dart';
import 'package:my_app/mcq_edit_screen.dart';
import 'package:my_app/topic.dart';
import 'package:my_app/topic_edit_screen.dart';
import 'package:provider/provider.dart';

import 'appstate.dart';

class QuestionsEditScreen extends StatelessWidget {
  final String? topicDocumentId;
  final Topic topic;
  const QuestionsEditScreen(
      {super.key, this.topicDocumentId, required this.topic});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Edit ${appState.topics[appState.selectedTopicIndex!].topicName}"),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return TopicEditScreen(
                      topic: appState.topics[appState.selectedTopicIndex!],
                    );
                  },
                  fullscreenDialog: true));
            },
          ),
        ],
      ),
      body: SafeArea(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: appState.questions.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(appState.questions[index].question),
                  onTap: () {
                    appState.selectedQuestionIndex = index;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MCQEditScreen(
                          question: appState.questions[index],
                          topic: topic,
                        ),
                      ),
                    );
                  },
                );
              })),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return MCQEditScreen(
                  topic: topic,
                );
              },
              fullscreenDialog: true));
        },
        label: const Text('Add MCQ'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
