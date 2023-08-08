part of 'home_cubit.dart';

enum HomeStatus {
  init,
  loading,
  success,
  error,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final List<QuestionModel> questions;
  final List<CategoryModel> categories;
  final List<AnswerModel> answers;
  final CategoryModel categoryModel;

  const HomeState({
    required this.status,
    required this.questions,
    required this.categories,
    required this.answers,
    required this.categoryModel,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<QuestionModel>? questions,
    List<CategoryModel>? categories,
    List<AnswerModel>? answers,
    CategoryModel? categoryModel,
  }) {
    return HomeState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      categories: categories ?? this.categories,
      answers: answers ?? this.answers,
      categoryModel: categoryModel ?? this.categoryModel,
    );
  }

  @override
  List<Object> get props => [
        status,
        questions,
        categories,
        answers,
        categoryModel,
      ];
}
