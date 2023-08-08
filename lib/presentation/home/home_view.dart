import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_overflow/core/getit/getit.dart';
import 'package:neon_overflow/core/responsive.dart';

import '../../data/model/question_model.dart';
import 'cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
    if (!Responsive.isXXLarge(context)) {
      return 0;
    }
    return 200;
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = context.read<HomeCubit>();
          if (state.status == HomeStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == HomeStatus.success) {}
          return Expanded(
            // Use Expanded to take the remaining available height
            child: Padding(
              padding: EdgeInsets.only(right: rightPaddingResponsive(context)),
              child: Column(
                children: [
                  const QuestionBarWidget(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.questions
                          .length, // Replace this with the actual count of cards
                      itemBuilder: (context, index) {
                        var question = state.questions[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CardWidget(
                            question: question,
                            cubit: cubit,
                            state: state,
                          ),
                        ); // Make sure CardWidget has a proper height
                      },
                    ),
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

class QuestionBarWidget extends StatelessWidget {
  const QuestionBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text("Questions",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins')),
        ElevatedButton.icon(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.purple)),
            onPressed: () {
              Navigator.pushNamed(context, "/addquestion");
            },
            icon: const Icon(Icons.add),
            label: const Text(
              "Ask Question",
              style: TextStyle(fontFamily: 'Poppins'),
            )),
      ]),
    );
  }
}

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  final HomeCubit cubit;
  final QuestionModel question;
  final HomeState state;
  CardWidget({
    super.key,
    required this.question,
    required this.cubit,
    required this.state,
  });

  String? fontFamily = "Poppins";
  String? categoryName = "iOS";
  String? fullName = "Doğukan Özgür Yılmaz";
  String? imageUrl = "https://picsum.photos/200";
  int? answerCount = 3;
  List<Color> colors = [const Color(0x897D00AA), const Color(0xFF7D00AA)];

  @override
  Widget build(BuildContext context) {
    // cubit.getByCategoryId(question.categoryId!);
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("snapshot.data!.imageUrl!"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "snapshot.data!.firstname!",
                        style: TextStyle(
                          color: const Color(0xFF202020),
                          fontSize: 16,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      "${question.createdAt!.day}",
                      style: TextStyle(
                        color: const Color(0xFF7D7D7D),
                        fontSize: 14,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CategoryCornerWidget(
                  colors: colors,
                  categoryName: "snapshot.data!.name,",
                  fontFamily: fontFamily),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              question.body!,
              style: TextStyle(
                color: const Color(0xFF303030),
                fontSize: 16,
                fontFamily: fontFamily,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          AnswersCountWidget(answerCount: answerCount, fontFamily: fontFamily),
        ],
      ),
    );
  }
}

class CategoryCornerWidget extends StatelessWidget {
  const CategoryCornerWidget({
    super.key,
    required this.colors,
    required this.categoryName,
    required this.fontFamily,
  });

  final List<Color> colors;
  final String? categoryName;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 53,
      height: 35,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.00, -1.00),
          end: const Alignment(0, 1),
          colors: colors,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          categoryName!,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class AnswersCountWidget extends StatelessWidget {
  const AnswersCountWidget({
    super.key,
    required this.answerCount,
    required this.fontFamily,
  });

  final int? answerCount;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return const Text("Answer Count");
  }
}
