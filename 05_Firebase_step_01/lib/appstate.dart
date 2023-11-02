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

  List<Question> questions = [];

  List<Topic> topics = [
    Topic(
      topicName: 'Math',
      author: 'JaneSmith',
      questions: [
        Question(
          question: 'What is 12 + 8?',
          options: ['18', '20', '22', '24'],
          correctAnswerIndex: 1,
        ),
        Question(
          question: 'Solve for x: 3x = 15',
          options: ['5', '10', '15', '20'],
          correctAnswerIndex: 0,
        ),
        // Add more math questions here...
      ],
    ),
    Topic(
      topicName: 'Art History',
      author: 'MariaArtLover',
      questions: [
        Question(
          question: 'Who painted the Mona Lisa?',
          options: [
            'Leonardo da Vinci',
            'Pablo Picasso',
            'Vincent van Gogh',
            'Michelangelo',
          ],
          correctAnswerIndex: 0,
        ),
        Question(
          question: 'Who created the sculpture "David"?',
          options: [
            'Michelangelo',
            'Pablo Picasso',
            'Vincent van Gogh',
            'Leonardo da Vinci',
          ],
          correctAnswerIndex: 0,
        ),
        // Add more art history questions here...
      ],
    ),
    Topic(
      topicName: 'Geography',
      author: 'JohnDoe',
      questions: [
        Question(
          question: 'What is the capital of France?',
          options: ['Paris', 'London', 'Berlin', 'Rome'],
          correctAnswerIndex: 0,
        ),
        Question(
          question: 'Which country is the Statue of Liberty located in?',
          options: [
            'France',
            'United States',
            'Italy',
            'Greece',
          ],
          correctAnswerIndex: 1,
        ),
        // Add more geography questions here...
      ],
    ),
  ];

  void questionsFromIndex(int index) {
    questions = topics[index].questions!;
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

  void addTopic(Topic topic) {
    topics.add(topic);
    notifyListeners();
  }

  void deleteTopic() {
    topics.removeAt(selectedTopicIndex!);
    notifyListeners();
  }

  void updateTopicName(String newTopicName) {
    topics[selectedTopicIndex!].topicName = newTopicName;
    notifyListeners();
  }

  void addQuestion(Question newQuestion) {
    questions.add(newQuestion);
    topics[selectedTopicIndex!].questions = questions;
    notifyListeners();
  }

  void updateQuestion(Question updateQuestion) {
    questions[selectedQuestionIndex!] = updateQuestion;
    topics[selectedTopicIndex!].questions = questions;
    notifyListeners();
  }

  void removeQuestion() {
    questions.removeAt(selectedQuestionIndex!);
    topics[selectedTopicIndex!].questions = questions;
    notifyListeners();
  }
}
