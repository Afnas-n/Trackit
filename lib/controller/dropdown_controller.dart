import 'package:flutter/material.dart';
import 'package:trackit/Model/dropdown_model.dart';


class DropdownController extends ChangeNotifier {
  final DropdownModel _dropdownModel = DropdownModel();

  String get selectedValue => _dropdownModel.selectedValue;

  void setSelectedValue(String newValue) {
    _dropdownModel.selectedValue = newValue;
    notifyListeners();
  }

  String getImageForSelectedValue() {
    return _dropdownModel.getImageForSelectedValue();
  }

  // New getter to access dropdown item keys
  Iterable<String> get dropdownItemKeys => _dropdownModel.dropdownItemImages.keys;
}
