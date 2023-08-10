import 'package:flutter/material.dart';

class RouteProvider extends ChangeNotifier {
  String _questionId = "";
  String get questionId => _questionId;

  void setQuestionId(String questionId) {
    _questionId = questionId;
    notifyListeners();
  }
}
