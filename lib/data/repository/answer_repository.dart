import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neon_overflow/data/model/answer_model.dart';

class AnswerRepository {
  late final CollectionReference<Map<String, dynamic>> _firestore;
  AnswerRepository() {
    _firestore = FirebaseFirestore.instance.collection('answers');
  }

  Future<List<AnswerModel>> getAll(String questionId) async {
    try {
      var querySnapshot = await _firestore
          .where('question_id', isEqualTo: questionId)
          .orderBy('created_at', descending: true)
          .get();
      var list = querySnapshot.docs
          .map((e) => AnswerModel.fromJson(e.data()))
          .toList();
      return list;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<String> create(AnswerModel model) async {
    try {
      var id = _firestore.doc().id;
      model.id = id;
      await _firestore.doc(id).set(model.toJson());
      return id;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await _firestore.doc(id).delete();
    } catch (e) {
      throw Exception(e);
    }
  }
}
