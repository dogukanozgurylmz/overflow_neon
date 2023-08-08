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
  String? fullName;

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
              child: Column(
                children: [
                  Row(children: [
                    Text("Questions"),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/addquestion");
                        },
                        child: Text("Ask Question")),
                  ]),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridViewResponsive(context)),
                    itemCount: 4, // Replace this with the actual count of cards
                    itemBuilder: (context, index) {
                      return CardWidget(); // Make sure CardWidget has a proper height
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  CardWidget({super.key});

  String? fontFamily = "Poppins";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 468,
      height: 239,
      child: Stack(
        children: [
          Container(
            width: 468,
            height: 239,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          Container(
            width: 53,
            height: 35,
            decoration: const ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0x897D00AA), Color(0xFF7D00AA)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            margin: const EdgeInsets.only(left: 415, top: 0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'iOS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: ShapeDecoration(
              image: const DecorationImage(
                image: NetworkImage("https://picsum.photos/200"),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            margin: const EdgeInsets.only(left: 10, top: 10),
          ),
          Container(
            margin: const EdgeInsets.only(left: 66, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Doğukan Özgür Yılmaz',
                  style: TextStyle(
                    color: Color(0xFF202020),
                    fontSize: 16,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '23.08.2023 23.30',
                  style: TextStyle(
                    color: Color(0xFF7D7D7D),
                    fontSize: 14,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 66, top: 65),
            width: 361,
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
              style: TextStyle(
                color: Color(0xFF303030),
                fontSize: 16,
                fontFamily: fontFamily,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            width: 89,
            height: 35,
            margin: const EdgeInsets.only(left: 3, top: 201),
            child: Container(
              margin: const EdgeInsets.only(left: 7, top: 5),
              child: Text(
                '3 answer',
                style: TextStyle(
                  color: Color(0xFF202020),
                  fontSize: 16,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
