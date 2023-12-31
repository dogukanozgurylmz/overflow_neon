// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:neon_overflow/core/responsive.dart';
import 'package:neon_overflow/data/repository/auth_repository.dart';
import 'package:neon_overflow/data/repository/category_repository.dart';
import 'package:neon_overflow/data/repository/question_repository.dart';
import 'package:neon_overflow/presentation/add_question/cubit/add_question_cubit.dart';

class AddQuestionView extends StatelessWidget {
  AddQuestionView({super.key});

  final CategoryRepository categoryRepository = CategoryRepository();
  final QuestionRepository questionRepository = QuestionRepository();
  final AuthRepository authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => AddQuestionCubit(
        categoryRepository: categoryRepository,
        questionRepository: questionRepository,
        authRepository: authRepository,
      ),
      child: BlocBuilder<AddQuestionCubit, AddQuestionState>(
        builder: (context, state) {
          var cubit = context.read<AddQuestionCubit>();
          return state.status == AddQuestionStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  Responsive.isLarge(context) ? 180 : 12),
                          child: Column(
                            children: [
                              SizedBox(
                                width: size.width,
                                child: TextField(
                                  controller: cubit.titleController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 5,
                                    ),
                                    labelText: "Title",
                                    isDense: true,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: size.width,
                                child: TextField(
                                  controller: cubit.explanationController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 5,
                                    ),
                                    labelText: "Explanation",
                                    isDense: true,
                                  ),
                                  maxLines: 10,
                                  minLines: 10,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  for (var category in state.categories)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: InkWell(
                                        onTap: () {
                                          cubit.selectedCategory(category.id!);
                                        },
                                        child: Chip(
                                          backgroundColor:
                                              state.selectedCategory ==
                                                      category.id
                                                  ? Colors.green
                                                  : null,
                                          label: Text(category.name!),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              QuillToolbar.basic(
                                  controller: cubit.quillcontroller),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                ),
                                child: SizedBox(
                                  height: 500,
                                  child: QuillEditor.basic(
                                    controller: cubit.quillcontroller,
                                    readOnly: false,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              state.isSend
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ElevatedButton(
                                      onPressed: () async {
                                        if (state.selectedCategory == "") {
                                          _scaffoldMessengerBuilder(
                                              context, 'Category is not empty');
                                        } else if (cubit
                                                .titleController.text.isEmpty ||
                                            cubit.titleController.text == "") {
                                          _scaffoldMessengerBuilder(
                                              context, 'Title is not empty');
                                        } else if (cubit.explanationController
                                                .text.isEmpty ||
                                            cubit.explanationController.text ==
                                                "") {
                                          _scaffoldMessengerBuilder(context,
                                              'Explanation is not empty');
                                        } else if (cubit
                                                .quillcontroller.document
                                                .isEmpty() ||
                                            cubit.quillcontroller.document
                                                    .length ==
                                                0) {
                                          _scaffoldMessengerBuilder(
                                              context, 'Editor is not empty');
                                        } else {
                                          await cubit.createQuestion();
                                          Navigator.pushNamed(context, '/home');
                                        }
                                      },
                                      child: const Text("Send"),
                                    ),
                              const SizedBox(height: 12),
                            ],
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

  void _scaffoldMessengerBuilder(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ));
  }
}
