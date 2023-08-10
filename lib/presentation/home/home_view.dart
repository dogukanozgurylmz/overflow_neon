import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_overflow/core/getit/getit.dart';
import 'package:neon_overflow/core/responsive.dart';
import 'package:neon_overflow/presentation/provider/route_provider.dart';
import 'dart:html' as html;

import '../../data/model/dto/question_dto.dart';
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
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
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
                      itemCount: state.questionModels.length,
                      itemBuilder: (context, index) {
                        var question = state.questionModels[index];
                        // CategoryModel? category;
                        // if (state.categoryMap.containsKey(question.id)) {
                        //   category = state.categoryMap[question.id];
                        // }
                        // print(category);

                        return GestureDetector(
                          onTap: () {
                            context
                                .read<RouteProvider>()
                                .setQuestionId(question.id!);
                            print(context.read<RouteProvider>().questionId);
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              Navigator.pushNamed(
                                context,
                                "/questiondetails/${question.id}",
                              );
                            });

                            // _updateUrlAndNavigate(
                            //     "/questiondetails/${question.id}");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CardWidget(
                              question: question,
                              // categoryModel: category!,
                              state: state,
                            ),
                          ),
                        );
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

  void _updateUrlAndNavigate(String path) {
    final newUrl = Uri.parse(path);
    html.window.history.pushState(null, '', newUrl.toString());
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
  final QuestionDtoModel question;
  // final CategoryModel categoryModel;
  final HomeState state;
  CardWidget({
    super.key,
    required this.question,
    // required this.categoryModel,
    required this.state,
  });

  List<Color> colors = [const Color(0x897D00AA), const Color(0xFF7D00AA)];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      image: NetworkImage(question.userPhoto!),
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
                        question.firstname!,
                        style: const TextStyle(
                          color: Color(0xFF202020),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      "${question.createdAt!.day}",
                      style: const TextStyle(
                        color: Color(0xFF7D7D7D),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CategoryCornerWidget(
                colors: colors,
                categoryName: question.categoryName,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              question.body!,
              style: const TextStyle(
                color: Color(0xFF303030),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${question.answerCount} answers"),
          ),
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
  });

  final List<Color> colors;
  final String? categoryName;

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
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
