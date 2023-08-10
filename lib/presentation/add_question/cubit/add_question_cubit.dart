import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:neon_overflow/data/model/category_model.dart';
import 'package:neon_overflow/data/model/question_model.dart';
import 'package:neon_overflow/data/repository/auth_repository.dart';
import 'package:neon_overflow/data/repository/question_repository.dart';

import '../../../data/repository/category_repository.dart';

part 'add_question_state.dart';

class AddQuestionCubit extends Cubit<AddQuestionState> {
  AddQuestionCubit({
    required CategoryRepository categoryRepository,
    required QuestionRepository questionRepository,
    required AuthRepository authRepository,
  })  : _categoryRepository = categoryRepository,
        _questionRepository = questionRepository,
        _authRepository = authRepository,
        super(
          const AddQuestionState(
            categories: [],
            status: AddQuestionStatus.init,
            selectedCategory: "",
            isSend: false,
          ),
        ) {
    init();
  }

  final CategoryRepository _categoryRepository;
  final QuestionRepository _questionRepository;
  final AuthRepository _authRepository;

  QuillController quillcontroller = QuillController.basic();
  TextEditingController titleController = TextEditingController();
  TextEditingController explanationController = TextEditingController();

  Future<void> init() async {
    emit(state.copyWith(status: AddQuestionStatus.loading));
    await getAllCategories();
    emit(state.copyWith(status: AddQuestionStatus.success));
  }

  Future<void> getAllCategories() async {
    var list = await _categoryRepository.getAll();
    emit(state.copyWith(categories: list));
  }

  void selectedCategory(String selected) {
    emit(state.copyWith(selectedCategory: selected));
  }

  Future<void> createQuestion() async {
    emit(state.copyWith(isSend: true));
    QuestionModel questionModel = QuestionModel(
      id: '',
      userId: _authRepository.currentUser!.uid,
      body: explanationController.text.trim(),
      quillBody: quillcontroller.document.toDelta().toJson(),
      title: titleController.text.trim(),
      status: true,
      categoryId: state.selectedCategory,
      createdAt: DateTime.now(),
    );
    await _questionRepository.create(questionModel);
    clear();
    emit(state.copyWith(isSend: false));
  }

  void clear() {
    titleController.clear();
    explanationController.clear();
    emit(state.copyWith(selectedCategory: ""));
    quillcontroller.clear();
  }
}
