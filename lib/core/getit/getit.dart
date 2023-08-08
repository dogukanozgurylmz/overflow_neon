import 'package:get_it/get_it.dart';
import 'package:neon_overflow/data/repository/answer_repository.dart';
import 'package:neon_overflow/data/repository/category_repository.dart';
import 'package:neon_overflow/data/repository/question_repository.dart';
import 'package:neon_overflow/data/repository/user_repository.dart';
import 'package:neon_overflow/presentation/home/cubit/home_cubit.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerFactory(() => HomeCubit(
        questionRepository: getIt(),
        categoryRepository: getIt(),
        answerRepository: getIt(),
        userRepository: getIt(),
      ));

  getIt.registerLazySingleton<QuestionRepository>(() => QuestionRepository());
  getIt.registerLazySingleton<CategoryRepository>(() => CategoryRepository());
  getIt.registerLazySingleton<AnswerRepository>(() => AnswerRepository());
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
}
