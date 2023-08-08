import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neon_overflow/data/model/answer_model.dart';
import 'package:neon_overflow/data/model/question_model.dart';
import 'package:neon_overflow/data/model/category_model.dart';
import 'package:neon_overflow/data/model/user_model.dart';
import 'package:neon_overflow/data/repository/answer_repository.dart';
import 'package:neon_overflow/data/repository/category_repository.dart';
import 'package:neon_overflow/data/repository/question_repository.dart';
import 'package:neon_overflow/data/repository/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required QuestionRepository questionRepository,
    required CategoryRepository categoryRepository,
    required AnswerRepository answerRepository,
    required UserRepository userRepository,
  })  : _questionRepository = questionRepository,
        _categoryRepository = categoryRepository,
        _answerRepository = answerRepository,
        _userRepository = userRepository,
        super(HomeState(
          status: HomeStatus.init,
          questions: const [],
          categories: const [],
          answers: const [],
          categoryModel: CategoryModel(
            id: "id",
            name: "name",
          ),
        )) {
    init();
  }

  final QuestionRepository _questionRepository;
  final CategoryRepository _categoryRepository;
  final AnswerRepository _answerRepository;
  final UserRepository _userRepository;

  Future<void> init() async {
    emit(state.copyWith(status: HomeStatus.loading));
    await getAllQuestions();
    await getAllCategories();
    emit(state.copyWith(status: HomeStatus.success));
  }

  Future<void> getAllQuestions() async {
    var list = await _questionRepository.getAll();
    emit(state.copyWith(questions: list));
  }

  Future<void> getAllCategories() async {
    var list = await _categoryRepository.getAll();
    emit(state.copyWith(categories: list));
  }

  Future<List<AnswerModel>> getAnswersByQuestionId(String questionId) async {
    var list = await _answerRepository.getAll(questionId);
    return list;
  }

  Future<UserModel> getUserById(String id) async {
    var userModel = await _userRepository.getById(id);
    return userModel;
  }

  Future<CategoryModel> getByCategoryId(String id) async {
    var categoryModel = await _categoryRepository.getById(id);
    // emit(state.copyWith(categoryModel: categoryModel));
    return categoryModel;
  }
}
