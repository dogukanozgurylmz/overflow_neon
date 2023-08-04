import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  String? id;
  String? userId;
  String? body;
  List<dynamic>? quillBody;
  String? title;
  bool? status;
  String? categoryId;
  DateTime? createdAt;

  QuestionModel({
    required this.id,
    required this.userId,
    required this.body,
    required this.quillBody,
    required this.title,
    required this.status,
    required this.categoryId,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'body': body,
      'quill_body': quillBody,
      'title': title,
      'status': status,
      'category_id': categoryId,
      'created_at': Timestamp.fromDate(createdAt!),
    };
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] != null ? json['id'] as String : null,
      userId: json['user_id'] != null ? json['user_id'] as String : null,
      body: json['body'] != null ? json['body'] as String : null,
      quillBody: json['quill_body'] != null
          ? List<dynamic>.from((json['quill_body'] as List<dynamic>))
          : null,
      title: json['title'] != null ? json['title'] as String : null,
      status: json['status'] != null ? json['status'] as bool : null,
      categoryId:
          json['category_id'] != null ? json['category_id'] as String : null,
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }
}
