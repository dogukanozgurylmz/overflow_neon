part of 'categories_cubit.dart';

enum CategoriesStatus {
  init,
  loading,
  success,
  error,
}

class CategoriesState extends Equatable {
  final CategoriesStatus status;
  final List<CategoryModel> categories;

  const CategoriesState({
    required this.status,
    required this.categories,
  });

  CategoriesState copyWith({
    CategoriesStatus? status,
    List<CategoryModel>? categories,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object> get props => [
        status,
        categories,
      ];
}
