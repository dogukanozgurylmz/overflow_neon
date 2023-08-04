import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_overflow/data/repository/category_repository.dart';
import 'package:neon_overflow/data/repository/question_repository.dart';
import 'package:neon_overflow/presentation/widgets/sidebar/sidebar.dart';

import '../../data/repository/answer_repository.dart';
import '../../data/repository/user_repository.dart';
import 'cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final QuestionRepository questionRepository = QuestionRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final AnswerRepository answerRepository = AnswerRepository();
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => HomeCubit(
        questionRepository: questionRepository,
        categoryRepository: categoryRepository,
        answerRepository: answerRepository,
        userRepository: userRepository,
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = context.read<HomeCubit>();
          // if (state.status == HomeStatus.loading) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          // if (state.status == HomeStatus.success) {}
          return Scaffold(
            backgroundColor: Colors.white,
            body: state.status == HomeStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    children: [
                      Sidebar(),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
