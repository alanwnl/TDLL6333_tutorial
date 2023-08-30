import 'package:flutter/foundation.dart';
import 'package:my_app/question.dart';

class AppState extends ChangeNotifier{
  int? selectedOptionIndex;
  int currentQuestionIndex = 0;

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
}