// lib/controller.dart
import 'package:flutter/material.dart';
import 'package:trackit/Model/bottombar_model.dart';

class BottombarCntrl extends ChangeNotifier {
  int _currentIndex = 0;
  final List<PageModel> _pages = [
    PageModel('Home Page'),
    PageModel('Notification Page'),
  ];

  int get currentIndex => _currentIndex;
  PageModel get currentPage => _pages[_currentIndex];

  void setIndex(int index) {
    if (index >= 0 && index < _pages.length) {
      _currentIndex = index;
      notifyListeners();
    }
  }
}
