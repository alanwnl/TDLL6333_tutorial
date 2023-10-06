import 'package:flutter/foundation.dart';
import 'package:my_app/question.dart';

class AppState extends ChangeNotifier {
  int? selectedOptionIndex;
  int currentQuestionIndex = 0;
  int currectCounter = 0;
  bool isCorrect = false;

  final List<Question> questions = [
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

  void checkAnswer() {
    if (selectedOptionIndex ==
        questions[currentQuestionIndex].correctAnswerIndex) {
      currectCounter++;
      isCorrect = true;
    }else{
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

  void resetQuiz(){
    selectedOptionIndex = null;
    currentQuestionIndex = 0;
    currectCounter = 0;
    notifyListeners();
  }
}
