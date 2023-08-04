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
}
