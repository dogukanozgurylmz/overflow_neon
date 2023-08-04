import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neon_overflow/data/model/question_model.dart';

class QuestionRepository {
  late final CollectionReference<Map<String, dynamic>> _firestore;
  QuestionRepository() {
    _firestore = FirebaseFirestore.instance.collection('questions');
  }

  Future<List<QuestionModel>> getAll() async {
    try {
      var querySnapshot =
          await _firestore.orderBy('created_at', descending: true).get();
      var list = querySnapshot.docs
          .map((e) => QuestionModel.fromJson(e.data()))
          .toList();
      return list;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> create(QuestionModel model) async {
    try {
      var id = _firestore.doc().id;
      model.id = id;
      await _firestore.doc(id).set(model.toJson());
      return id;
    } catch (e) {
      throw Exception(e);
    }
  }
}
