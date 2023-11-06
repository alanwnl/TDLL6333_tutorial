import 'package:flutter/material.dart';
import 'package:my_app/question.dart';
import 'package:my_app/topic.dart';
import 'package:provider/provider.dart';

import 'appstate.dart';

class MCQEditScreen extends StatefulWidget {
  final Topic topic;
  final Question? question;
  MCQEditScreen({super.key, this.question, required this.topic});

  @override
  State<MCQEditScreen> createState() => _MCQEditScreenState();
}

class _MCQEditScreenState extends State<MCQEditScreen> {
  var questionController = TextEditingController();
  var answerControllers = List.generate(4, (index) => TextEditingController());
  int correctAnswerIndex = 0; // Default value
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.question != null) {
      questionController.text = widget.question!.question;
      for (var i = 0; i < 4; i++) {
        answerControllers[i].text = widget.question!.options[i];
      }
      correctAnswerIndex = widget.question!.correctAnswerIndex;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: widget.question == null
            ? const Text("Create MCQ")
            : const Text("Edit MCQ"),
        backgroundColor: Colors.pink,
        actions: widget.question == null
            ? <Widget>[]
            : <Widget>[
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete',
                  onPressed: () {
                    appState.removeQuestion(widget.question!, widget.topic);
                    Navigator.pop(context);
                  },
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
                  controller: questionController,
                  restorationId: 'question',
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Question",
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the question';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                for (var i = 0; i < 4; i++)
                  RadioListTile(
                    title: TextFormField(
                      controller: answerControllers[i],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Answer ${i + 1}',
                      ),
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the answer';
                        }
                        return null;
                      },
                    ),
                    value: i,
                    groupValue: correctAnswerIndex,
                    onChanged: (newValue) {
                      setState(() {
                        correctAnswerIndex = newValue!;
                      });
                    },
                  ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final options = answerControllers
                            .map((controller) => controller.text)
                            .toList();
                        final newQuestion = Question(
                          question: questionController.text,
                          options: options,
                          correctAnswerIndex: correctAnswerIndex,
                        );
                        if (widget.question == null) {
                          appState.addQuestion(newQuestion, widget.topic);
                        } else {
                          appState.updateQuestion(
                              widget.question!, newQuestion, widget.topic);
                        }

                        questionController.clear();
                        for (var controller in answerControllers) {
                          controller.clear();
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: widget.question == null
                        ? const Text('Create MCQ')
                        : const Text('Update MCQ'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
