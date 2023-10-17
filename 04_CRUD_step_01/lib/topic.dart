import 'question.dart';

class Topic {
  String userId;
  String? topicId;
  String topicName;
  String? author;
  List<Question>? questions;
  DateTime? createdAt;

  Topic({
    required this.userId,
    this.topicId,
    required this.topicName,
    this.questions,
    this.author,
    this.createdAt,
  });
}
