import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neon_overflow/data/model/category_model.dart';
import 'package:neon_overflow/data/repository/category_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({
    required CategoryRepository categoryRepository,
  })  : _categoryRepository = categoryRepository,
        super(const CategoriesState(
          status: CategoriesStatus.init,
          categories: [],
        )) {
    init();
  }

  final CategoryRepository _categoryRepository;

  Future<void> init() async {
    emit(state.copyWith(status: CategoriesStatus.loading));
    await getCategories();
    emit(state.copyWith(status: CategoriesStatus.success));
  }

  Future<void> getCategories() async {
    var list = await _categoryRepository.getAll();
    emit(state.copyWith(categories: list));
  }
}
