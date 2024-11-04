import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetController with ChangeNotifier {
  double _budgetAmount = 0.0;
  bool _isEditing = false;

  BudgetController() {
    loadBudget();
  }

  double get budgetAmount => _budgetAmount;
  bool get isEditing => _isEditing;

  setEditing(bool value) {
    _isEditing = value;
    notifyListeners();
  }

  void updateBudget(double amount) async {
    _budgetAmount = amount;
    notifyListeners();
    await saveBudget(amount);
  }

  Future<void> saveBudget(double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('budgetAmount', amount);
  }

  Future<void> loadBudget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _budgetAmount = prefs.getDouble('budgetAmount') ?? 0.0;
    notifyListeners();
  }

  void toggleEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
  }
}
