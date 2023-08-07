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

  int gridViewResponsive(context) {
    var result = Responsive.isExtraSmall(context) ||
        Responsive.isMedium(context) ||
        Responsive.isSmall(context);
    if (result) {
      return 1;
    }
    return 2;
  }

  double rightPaddingResponsive(context) {
    var result = Responsive.isSmall(context) ||
        Responsive.isExtraSmall(context) ||
        Responsive.isMedium(context) ||
        Responsive.isLarge(context) ||
        Responsive.isExtraLarge(context);
    if (result) {
      return 0;
    }
    return 200;
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.sizeOf(context);
    print(size);
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
              padding: EdgeInsets.only(right: rightPaddingResponsive(context)),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridViewResponsive(context)),
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
