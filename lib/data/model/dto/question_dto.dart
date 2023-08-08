class QuestionDtoModel {
  String? id;
  String? firstname;
  String? lastname;
  String? userPhoto;
  String? body;
  List<dynamic>? quillBody;
  String? title;
  bool? status;
  String? categoryName;
  int? answerCount;
  DateTime? createdAt;

  QuestionDtoModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.userPhoto,
    required this.body,
    required this.quillBody,
    required this.title,
    required this.status,
    required this.categoryName,
    required this.answerCount,
    required this.createdAt,
  });
}
