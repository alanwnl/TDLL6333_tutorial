import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_app/question.dart';
import 'package:my_app/topic.dart';

class AppState extends ChangeNotifier {
  int? selectedOptionIndex;
  int currentQuestionIndex = 0;
  int currectCounter = 0;
  bool isCorrect = false;

  int? selectedTopicIndex;
  int? selectedQuestionIndex;

  List<Question> _questions = [];
  List<Question> get questions => _questions;

  // List<Topic> topics = [
  //   Topic(
  //     topicName: 'Math',
  //     author: 'JaneSmith',
  //     questions: [
  //       Question(
  //         question: 'What is 12 + 8?',
  //         options: ['18', '20', '22', '24'],
  //         correctAnswerIndex: 1,
  //       ),
  //       Question(
  //         question: 'Solve for x: 3x = 15',
  //         options: ['5', '10', '15', '20'],
  //         correctAnswerIndex: 0,
  //       ),
  //       // Add more math questions here...
  //     ],
  //   ),
  //   Topic(
  //     topicName: 'Art History',
  //     author: 'MariaArtLover',
  //     questions: [
  //       Question(
  //         question: 'Who painted the Mona Lisa?',
  //         options: [
  //           'Leonardo da Vinci',
  //           'Pablo Picasso',
  //           'Vincent van Gogh',
  //           'Michelangelo',
  //         ],
  //         correctAnswerIndex: 0,
  //       ),
  //       Question(
  //         question: 'Who created the sculpture "David"?',
  //         options: [
  //           'Michelangelo',
  //           'Pablo Picasso',
  //           'Vincent van Gogh',
  //           'Leonardo da Vinci',
  //         ],
  //         correctAnswerIndex: 0,
  //       ),
  //       // Add more art history questions here...
  //     ],
  //   ),
  //   Topic(
  //     topicName: 'Geography',
  //     author: 'JohnDoe',
  //     questions: [
  //       Question(
  //         question: 'What is the capital of France?',
  //         options: ['Paris', 'London', 'Berlin', 'Rome'],
  //         correctAnswerIndex: 0,
  //       ),
  //       Question(
  //         question: 'Which country is the Statue of Liberty located in?',
  //         options: [
  //           'France',
  //           'United States',
  //           'Italy',
  //           'Greece',
  //         ],
  //         correctAnswerIndex: 1,
  //       ),
  //       // Add more geography questions here...
  //     ],
  //   ),
  // ];
  //

  List<Topic> _topics = [];
  List<Topic> get topics => _topics;

  StreamSubscription<QuerySnapshot>? _topicsSubscription;
  AppState() {
    init();
  }
  Future<void> init() async {
    streamTopicsQuery();
  }

  Future<void> streamTopicsQuery() async {
    try {
      _topicsSubscription?.cancel();
      _topicsSubscription = FirebaseFirestore.instance
          .collection('topics')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen(
            (snapshot) {
          _topics =
              snapshot.docs.map((doc) => Topic.fromSnapshot(doc)).toList();
          notifyListeners();
        },
      );
    } catch (error) {
      print('Error fetching topics: $error');
    }
  }

  void questionsFromIndex(int index) {
    _questions = topics[index].questions!;
  }

  void checkAnswer() {
    if (selectedOptionIndex ==
        questions[currentQuestionIndex].correctAnswerIndex) {
      currectCounter++;
      isCorrect = true;
    } else {
      isCorrect = false;
    }
    notifyListeners();
  }

  bool nextQuestion() {
    selectedOptionIndex = null;
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      notifyListeners();
      return true;
    } else {
      currentQuestionIndex = 0;
      notifyListeners();
      return false;
    }
  }

  void resetQuiz() {
    selectedOptionIndex = null;
    currentQuestionIndex = 0;
    currectCounter = 0;
    notifyListeners();
  }


  Future<void> addTopic(Topic topic) async {
    try {
      await FirebaseFirestore.instance.collection('topics').add({
        'createdAt': DateTime.now(),
        // 'userId': currentUser!.uid,
        // 'author': userDetails.username,
        // 'userId': currentUser!.uid,
        'topicName': topic.topicName,
        'questions': [],
      });
      debugPrint('Topic ${topic.topicName} added to Firestore.');
    } catch (error) {
      print('Error adding topic to Firestore: $error');
    }
  }


  Future<void> deleteTopic(Topic topic) async {
    try {
      await FirebaseFirestore.instance
          .collection('topics')
          .doc(topic.topicId)
          .delete()
          .then((value) {
        _topics.remove(topic);
        debugPrint('Topic ${topic.topicName} deleted from Firestore.');
        notifyListeners();
      });
    } catch (error) {
      print('Error deleting topic from Firestore: $error');
    }
  }


  Future<void> updateTopicName(Topic topic, String newTopicName) async {
    try {
      await FirebaseFirestore.instance
          .collection('topics')
          .doc(topic.topicId)
          .update({'topicName': newTopicName});
    } catch (error) {
      print('Error updating topic name: $error');
    }
  }

  Future<void> addQuestion(Question question, Topic topic) async {
    try {
      await FirebaseFirestore.instance
          .collection('topics')
          .doc(topic.topicId)
          .update({
        'questions': FieldValue.arrayUnion([question.toMap()])
      }).then((value) {
        print('Data fetching completed.');
        _questions.add(question);
        notifyListeners();
      });
      debugPrint('Question added to topic ${topic.topicName} in Firestore.');
    } catch (error) {
      print('Error adding question to topic in Firestore: $error');
    }
  }

  Future<void> removeQuestion(Question question, Topic topic) async {
    try {
      await FirebaseFirestore.instance
          .collection('topics')
          .doc(topic.topicId)
          .update({
        'questions': FieldValue.arrayRemove([question.toMap()])
      }).then((value) {
        _questions.remove(question);
        notifyListeners();
      });
      debugPrint(
          'Question removed from topic ${topic.topicName} in Firestore.');
    } catch (error) {
      print('Error removing question from topic in Firestore: $error');
    }
  }

  Future<void> updateQuestion(
      Question oldQuestion, Question newQuestion, Topic topic) async {
    try {
      final oldQuestionIndex = _questions.indexOf(oldQuestion);
      if (oldQuestionIndex != -1) {
        final updatedQuestions = List<Question>.from(_questions);
        updatedQuestions[oldQuestionIndex] = newQuestion;

        // Convert questions to a list of maps
        final questionsAsMaps = updatedQuestions.map((q) => q.toMap()).toList();

        // Update questions in Firestore
        await FirebaseFirestore.instance
            .collection('topics')
            .doc(topic.topicId)
            .update({'questions': questionsAsMaps});

        // Update local state
        _questions = updatedQuestions;
        notifyListeners();

        debugPrint(
            'Question updated in topic ${topic.topicName} in Firestore.');
      }
    } catch (error) {
      print('Error updating question in topic in Firestore: $error');
    }
  }
}
