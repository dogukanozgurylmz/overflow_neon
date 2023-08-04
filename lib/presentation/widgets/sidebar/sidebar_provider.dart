import 'package:flutter/material.dart';

class SidebarProvider extends ChangeNotifier {
  SidebarStatus _status = SidebarStatus.home;

  SidebarStatus get getStatus => _status;

  void setStatus(SidebarStatus status) {
    _status = status;
    notifyListeners();
  }
}

enum SidebarStatus {
  home,
  categories,
  notifications,
  favorites,
  myquestions,
  settings,
}
