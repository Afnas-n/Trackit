import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackit/Model/userexpense_model.dart';

class SharedPrefService {
  static const String _expensesKey = 'expenses';

  Future<void> saveExpenses(List<UserExpense> expenses) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> expenseStrings = expenses.map((expense) => jsonEncode(expense.toMap())).toList();
    await prefs.setStringList(_expensesKey, expenseStrings);
  }

  Future<List<UserExpense>> loadExpenses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? expenseStrings = prefs.getStringList(_expensesKey);
    
    if (expenseStrings == null) {
      return []; // Return an empty list if no expenses are saved
    }

    return expenseStrings.map((expenseString) {
      return UserExpense.fromMap(jsonDecode(expenseString));
    }).toList();
  }
}
