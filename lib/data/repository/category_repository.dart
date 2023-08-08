import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neon_overflow/data/model/category_model.dart';

class CategoryRepository {
  late final CollectionReference<Map<String, dynamic>> _firestore;
  CategoryRepository() {
    _firestore = FirebaseFirestore.instance.collection('categories');
  }

  Future<List<CategoryModel>> getAll() async {
    try {
      var querySnapshot = await _firestore.get();
      var list = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      return list;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CategoryModel> getById(String id) async {
    var querySnapshot = await _firestore.where('id', isEqualTo: id).get();
    return CategoryModel.fromJson(querySnapshot.docs.first.data());
  }
}
