import 'package:cloud_firestore/cloud_firestore.dart';

import 'question.dart';

class Topic {
  String? username;
  String topicName;
  List<Question>? questions;
  Timestamp? createdAt;
  DocumentReference? author;


  Topic({
    this.username,
    required this.topicName,
    this.questions,
    this.author,
    this.createdAt,
  });

  factory Topic.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;
    return Topic(
      username: data?["username"],
      topicName: data?['topicName'] as String? ?? '',
      author: data?['author'] as DocumentReference?,
      createdAt: data?['createdAt'] as Timestamp? ?? Timestamp(0, 0),
      questions: (data?['questions'] as List<dynamic>?)
          ?.map((q) => Question.fromMap(q))
          .toList() ?? [], // Provide an empty list as a default
    );
  }
}