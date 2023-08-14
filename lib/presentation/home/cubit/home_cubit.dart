import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neon_overflow/data/model/answer_model.dart';
import 'package:neon_overflow/data/model/dto/question_dto.dart';
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
        super(const HomeState(
          status: HomeStatus.init,
          questionModels: [],
        )) {
    init();
  }

  final QuestionRepository _questionRepository;
  final CategoryRepository _categoryRepository;
  final AnswerRepository _answerRepository;
  final UserRepository _userRepository;

  final List<QuestionModel> _questions = [];
  final List<CategoryModel> _categories = [];

  Future<void> init() async {
    emit(state.copyWith(status: HomeStatus.loading));
    await getAllQuestions();
    await getAllCategories();
    await deneme();
    emit(state.copyWith(status: HomeStatus.success));
  }

  Future<void> getAllQuestions() async {
    var list = await _questionRepository.getAll();
    _questions.addAll(list);
  }

  Future<void> getAllCategories() async {
    var list = await _categoryRepository.getAll();
    _categories.addAll(list);
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
    return categoryModel;
  }

  Future<void> deneme() async {
    List<QuestionDtoModel> questionModels = [];
    for (var q in _questions) {
      var c = _categories.firstWhere((element) => element.id == q.categoryId);
      var userModel = await getUserById(q.userId!);
      // var list = await getAnswersByQuestionId(q.id!);
      QuestionDtoModel model = QuestionDtoModel(
        id: q.id,
        firstname: userModel.firstname,
        lastname: userModel.lastname,
        userPhoto: userModel.imageUrl,
        body: q.body,
        quillBody: q.quillBody,
        title: q.title,
        status: q.status,
        categoryName: c.name,
        answerCount: 1,
        createdAt: q.createdAt,
      );
      questionModels.add(model);
    }
    emit(state.copyWith(questionModels: questionModels));
  }
}
