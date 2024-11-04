import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ExpenseController with ChangeNotifier {
  List<UserExpense> _expenses = [];
  List<UserExpense> get expenses => _expenses;

  ExpenseController() {
    loadExpenses(); // Load expenses when the controller is created
  }

  void addExpense(String category, String imagePath, double amount, String notes, DateTime date) {
    UserExpense newExpense = UserExpense(category: category, imagePath: imagePath, amount: amount, notes: notes, date: date);
    _expenses.add(newExpense);
    saveExpenses(); // Save expenses whenever a new one is added
    notifyListeners();
  }

  Future<void> saveExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> expensesJson = _expenses.map((expense) => jsonEncode(expense.toJson())).toList();
    await prefs.setStringList('expenses', expensesJson);
  }

  Future<void> loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? expensesJson = prefs.getStringList('expenses');

    if (expensesJson != null) {
      _expenses = expensesJson.map((json) => UserExpense.fromJson(jsonDecode(json))).toList();
    }
    notifyListeners();
  }
}

class UserExpense {
  String category;
  String imagePath;
  double amount;
  String notes;
  DateTime date;

  UserExpense({
    required this.category,
    required this.imagePath,
    required this.amount,
    required this.notes,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'imagePath': imagePath,
      'amount': amount,
      'notes': notes,
      'date': date.toIso8601String(),
    };
  }

  factory UserExpense.fromJson(Map<String, dynamic> json) {
    return UserExpense(
      category: json['category'],
      imagePath: json['imagePath'],
      amount: json['amount'],
      notes: json['notes'],
      date: DateTime.parse(json['date']),
    );
  }
}
