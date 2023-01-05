import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String? topic = "";
  String? question = "";
  String? questionImg = "";
  String? answer = "";
  List<String>? choices = [];

  Question(
      {required this.topic,
      required this.question,
      required this.questionImg,
      required this.answer,
      required this.choices});

  factory Question.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Question(
      topic: data?['topic'],
      question: data?['question'],
      questionImg: data?['questionImg'],
      answer: data?['answer'],
      choices:
          data?['choices'] is Iterable ? List.from(data?['choices']) : null,
    );
  }

  factory Question.fromNonDataFirestore(
    Map<String, dynamic> snapshotMap,
  ) {
    final data = snapshotMap;
    return Question(
      topic: data['topic'],
      question: data['question'],
      questionImg: data['questionImg'],
      answer: data['answer'],
      choices: data['choices'] is Iterable ? List.from(data['choices']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (topic != null) "topic": topic,
      if (question != null) "question": question,
      if (questionImg != null) "questionImg": questionImg,
      if (answer != null) "answer": answer,
      if (choices != null) "choices": choices,
    };
  }
}
