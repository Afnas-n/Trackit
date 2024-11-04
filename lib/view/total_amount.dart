import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit/controller/expence_controller.dart';
import 'package:intl/intl.dart';

class TotalAmount extends StatelessWidget {
  const TotalAmount({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseController = Provider.of<ExpenseController>(context);

    // Group expenses by month and year
    final Map<String, double> monthlyTotals = {};

    for (final expense in expenseController.expenses) {
      final date = expense.date;
      final String monthYear = DateFormat('MMMM yyyy').format(date);

      if (monthlyTotals.containsKey(monthYear)) {
        monthlyTotals[monthYear] = monthlyTotals[monthYear]! + expense.amount;
      } else {
        monthlyTotals[monthYear] = expense.amount;
      }
    }

    return Column(
      children: [
        const Text(
          'Total Expenses by Month',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: monthlyTotals.length,
            itemBuilder: (context, index) {
              final monthYear = monthlyTotals.keys.elementAt(index);
              final totalAmount = monthlyTotals[monthYear]!;
              return ListTile(
                title: Text(monthYear),
                trailing: Text('₹${totalAmount.toStringAsFixed(2)}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
