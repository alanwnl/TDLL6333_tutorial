import 'package:flutter/material.dart';
import 'package:my_app/topic.dart';
import 'package:provider/provider.dart';

import 'appstate.dart';

class TopicEditScreen extends StatefulWidget {
  final Topic topic;
  const TopicEditScreen({required this.topic});

  @override
  State<TopicEditScreen> createState() => _TopicEditScreenState();
}

class _TopicEditScreenState extends State<TopicEditScreen> {
  var topicNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    topicNameController.text = widget.topic.topicName;
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Topic"),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                appState.updateTopicName(widget.topic,
                    topicNameController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 20),
                TextFormField(
                  controller: topicNameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Update Topic Name",
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the topic';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                      onPressed: () {
                        appState.deleteTopic(widget.topic);
                        Navigator.popUntil(
                            context, (Route<dynamic> route) => route.isFirst);
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text("DELETE topic"),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
