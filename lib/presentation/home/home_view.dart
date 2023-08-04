import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_overflow/core/responsive.dart';
import 'package:neon_overflow/data/repository/category_repository.dart';
import 'package:neon_overflow/data/repository/question_repository.dart';
import 'package:neon_overflow/presentation/widgets/sidebar/sidebar.dart';
import 'package:provider/provider.dart';

import '../../data/repository/answer_repository.dart';
import '../../data/repository/user_repository.dart';
import '../widgets/sidebar/sidebar_provider.dart';
import 'cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final QuestionRepository questionRepository = QuestionRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final AnswerRepository answerRepository = AnswerRepository();
  final UserRepository userRepository = UserRepository();

  int responsiveControl(context) {
    if (!Responsive.isDesktop(context)) {
      return 1;
    }
    return 2;
  }

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
          return Expanded(
            // Use Expanded to take the remaining available height
            child: Padding(
              padding: EdgeInsets.only(
                  right: Responsive.isDesktop(context) ? 120 : 0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: responsiveControl(context)),
                itemCount: 4, // Replace this with the actual count of cards
                itemBuilder: (context, index) {
                  return Placeholder(); // Make sure CardWidget has a proper height
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
