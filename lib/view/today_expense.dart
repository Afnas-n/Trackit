import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:trackit/controller/expence_controller.dart';

class TodayExpense extends StatelessWidget {
  const TodayExpense({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseController = Provider.of<ExpenseController>(context);

    // Get current date
    final today = DateTime.now();
    final currentMonth = DateFormat('MMMM yyyy').format(today);

    // Check if today is the last day of the month
    final isLastDayOfMonth =
        today.day == DateTime(today.year, today.month + 1, 0).day;
    final displayMonth = isLastDayOfMonth
        ? DateFormat('MMMM yyyy').format(today.add(const Duration(days: 1)))
        : currentMonth;

    // Calculate total expenses for the current month
    double totalAmount = expenseController.expenses.fold(0.0, (sum, expense) {
      if (expense.date.month == today.month &&
          expense.date.year == today.year) {
        return sum + expense.amount;
      }
      return sum;
    });

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                displayMonth,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Total: ₹${totalAmount.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: expenseController.expenses.length,
            itemBuilder: (context, index) {
              final expense = expenseController.expenses[index];
              return ListTile(
                leading: Image.asset(
                  expense.imagePath,
                  width: 40,
                  height: 40,
                ),
                title: Text('${expense.category} - ₹${expense.amount}'),
                subtitle: Text(
                  '${DateFormat('dd MMMM yyyy').format(expense.date)}\nNote: ${expense.notes}',
                  style: const TextStyle(color: Colors.grey),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
