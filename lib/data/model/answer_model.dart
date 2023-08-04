import 'package:cloud_firestore/cloud_firestore.dart';

class AnswerModel {
  String? id;
  String? answer;
  DateTime? createdAt;
  String? userId;
  String? questionId;

  AnswerModel({
    required this.id,
    required this.answer,
    required this.createdAt,
    required this.userId,
    required this.questionId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'answer': answer,
      'created_at': Timestamp.fromDate(createdAt!),
      'user_id': userId,
      'question_id': questionId,
    };
  }

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'] != null ? json['id'] as String : null,
      answer: json['answer'] != null ? json['answer'] as String : null,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      userId: json['user_id'] != null ? json['user_id'] as String : null,
      questionId:
          json['question_id'] != null ? json['question_id'] as String : null,
    );
  }
}
