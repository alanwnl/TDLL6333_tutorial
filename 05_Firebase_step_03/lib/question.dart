class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  Question({required this.question,
    required this.options,
    required this.correctAnswerIndex});

  factory Question.fromMap(Map<String, dynamic> map) {
    final question = map['question'] as String?;
    final options = List<String>.from(map['options'] ?? []);
    final correctAnswerIndex = map['correctAnswerIndex'] as int?;

    if (question == null || correctAnswerIndex == null) {
      throw FormatException("Invalid question map. Missing required fields.");
    }

    return Question(
      question: question,
      options: options,
      correctAnswerIndex: correctAnswerIndex,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
    };
  }
}