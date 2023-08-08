import 'package:flutter/material.dart';

class SidebarProvider extends ChangeNotifier {
  SidebarStatus _status = SidebarStatus.home;
  int _selectedIndex = 0;

  SidebarStatus get getStatus => _status;

  int get selectedIndex => _selectedIndex;

  void setStatus(SidebarStatus status) {
    _status = status;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
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
