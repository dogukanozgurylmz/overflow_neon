import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? imageUrl;
  DateTime? createdAt;
  String? firstname;
  String? lastname;
  String? email;

  UserModel({
    required this.id,
    required this.imageUrl,
    required this.createdAt,
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'image_url': imageUrl,
      'created_at': Timestamp.fromDate(createdAt!),
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] != null ? json['id'] as String : null,
      imageUrl: json['image_url'] != null ? json['image_url'] as String : null,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      firstname: json['firstname'] != null ? json['firstname'] as String : null,
      lastname: json['lastname'] != null ? json['lastname'] as String : null,
      email: json['email'] != null ? json['email'] as String : null,
    );
  }
}
