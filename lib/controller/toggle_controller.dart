import 'package:flutter/material.dart';

class ToggleController with ChangeNotifier {
 List<bool> _selections = [true, false]; 

  List<bool> get selections => _selections;

void updateSelection(int index) {
  if (index >= 0 && index < _selections.length) {
    _selections = List.generate(_selections.length, (_) => false);
    _selections[index] = true;
    notifyListeners();
  }
}

}
