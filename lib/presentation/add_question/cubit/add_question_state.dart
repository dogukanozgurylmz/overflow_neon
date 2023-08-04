part of 'add_question_cubit.dart';

enum AddQuestionStatus {
  init,
  loading,
  success,
  error,
}

class AddQuestionState extends Equatable {
  final AddQuestionStatus status;
  final List<CategoryModel> categories;
  final String selectedCategory;
  final bool isSend;

  const AddQuestionState({
    required this.status,
    required this.categories,
    required this.selectedCategory,
    required this.isSend,
  });

  AddQuestionState copyWith({
    AddQuestionStatus? status,
    List<CategoryModel>? categories,
    String? selectedCategory,
    bool? isSend,
  }) {
    return AddQuestionState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isSend: isSend ?? this.isSend,
    );
  }

  @override
  List<Object> get props => [
        status,
        categories,
        selectedCategory,
        isSend,
      ];
}
