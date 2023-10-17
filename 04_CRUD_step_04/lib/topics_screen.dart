import 'package:flutter/material.dart';
import 'package:my_app/questions_screen.dart';
import 'package:my_app/topic.dart';
import 'package:provider/provider.dart';

import 'appstate.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("EDU MCQ"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'Profile',
              onPressed: () {},
            ),
          ]),
      body: SafeArea(
          child: appState.topics.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: appState.topics.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(appState.topics[index].topicName),
                      onTap: () {
                        appState.questionsFromIndex(index);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuestionScreen()),
                        );
                      },
                    );
                  })
              : const Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Click + button to create a new topic',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formKey = GlobalKey<FormState>();
          final newTopicController = TextEditingController();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Create New Topic'),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Enter the name of the topic'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the name of the topic';
                        }
                        return null;
                      },
                      controller: newTopicController,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Create'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      appState.addTopic(Topic(
                          topicName: newTopicController.text,
                          questions: []));
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
