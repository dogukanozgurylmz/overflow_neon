part of 'home_cubit.dart';

enum HomeStatus {
  init,
  loading,
  success,
  error,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final List<QuestionDtoModel> questionModels;

  const HomeState({
    required this.status,
    required this.questionModels,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<QuestionDtoModel>? questionModels,
  }) {
    return HomeState(
      status: status ?? this.status,
      questionModels: questionModels ?? this.questionModels,
    );
  }

  @override
  List<Object> get props => [
        status,
        questionModels,
      ];
}
