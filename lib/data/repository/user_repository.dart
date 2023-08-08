import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neon_overflow/data/model/user_model.dart';

class UserRepository {
  late final CollectionReference<Map<String, dynamic>> _firestore;
  UserRepository() {
    _firestore = FirebaseFirestore.instance.collection('users');
  }

  Future<UserModel> getById(String id) async {
    try {
      var querySnapshot = await _firestore.where('id', isEqualTo: id).get();
      var userModel = UserModel.fromJson(querySnapshot.docs.first.data());
      return userModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> create(UserModel model) async {
    try {
      await _firestore.doc().set(model.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> hasUser(String id) async {
    var querySnapshot = await _firestore.where('id', isEqualTo: id).get();
    if (querySnapshot.docs.isEmpty) {
      return false;
    }
    return true;
  }
}
