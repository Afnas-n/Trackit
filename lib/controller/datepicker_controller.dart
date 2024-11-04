import 'package:flutter/material.dart';
import 'package:trackit/Model/datepicker_model.dart';

class DatepickerController extends ChangeNotifier {
  final DateModel _dateModel = DateModel();

  DateTime get selectedDate => _dateModel.date;

  void updateDate(DateTime date) {
    _dateModel.date = date;
    notifyListeners();
  }
}
