import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'question_details_state.dart';

class QuestionDetailsCubit extends Cubit<QuestionDetailsState> {
  QuestionDetailsCubit() : super(QuestionDetailsInitial());
}
