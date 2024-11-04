import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController with ChangeNotifier {
  double? _amount;
  String? _note;
  String? _category;
  String? _date;

  // Load data from shared preferences
  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _amount = prefs.getDouble('amount');
    _note = prefs.getString('note');
    _category = prefs.getString('category');
    _date = prefs.getString('date');
    notifyListeners();
  }

  // Save data to shared preferences
  Future<void> savePreferences({
    required double amount,
    required String note,
    required String category,
    required String date,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('amount', amount);
    await prefs.setString('note', note);
    await prefs.setString('category', category);
    await prefs.setString('date', date);

    _amount = amount;
    _note = note;
    _category = category;
    _date = date;
    notifyListeners();
  }

  // Getter methods for accessing saved data
  double? get amount => _amount;
  String? get note => _note;
  String? get category => _category;
  String? get date => _date;
}
