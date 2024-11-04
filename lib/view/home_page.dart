import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit/controller/toggle_controller.dart';
import 'package:trackit/controller/budget_controller.dart';
import 'package:trackit/controller/expence_controller.dart';
import 'package:trackit/view/today_expense.dart';
import 'package:trackit/view/total_amount.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetController = Provider.of<BudgetController>(context);
    final expenseController = Provider.of<ExpenseController>(context);

    double totalAmount = expenseController.expenses.fold(0.0, (sum, expense) {
      final date = expense.date;
      if (date.month == DateTime.now().month &&
          date.year == DateTime.now().year) {
        return sum + expense.amount;
      }
      return sum;
    });

    double remainingBudget = budgetController.budgetAmount - totalAmount;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 33, 206, 153),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'My budget',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        const Text(
                          "₹",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        budgetController.isEditing
                            ? SizedBox(
                                width: 100,
                                child: TextFormField(
                                  initialValue:
                                      budgetController.budgetAmount.toString(),
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Budget",
                                    hintStyle: TextStyle(
                                      color: Colors.white54,
                                    ),
                                  ),
                                  onFieldSubmitted: (value) {
                                    double newAmount =
                                        double.tryParse(value) ?? 0;
                                    budgetController.updateBudget(newAmount);
                                    budgetController.setEditing(false);
                                  },
                                ),
                              )
                            : Text(
                                budgetController.budgetAmount
                                    .toStringAsFixed(2),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        IconButton(
                          onPressed: () {
                            budgetController.toggleEditing();
                          },
                          icon: budgetController.isEditing
                              ? const Icon(Icons.close, color: Colors.white)
                              : const Icon(Icons.edit, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Remaining: ₹${remainingBudget.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: remainingBudget < 1000 || remainingBudget < 0
                            ? Colors.red
                            : Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 270,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Consumer<ToggleController>(
                      builder: (context, togglecontroller, child) {
                    return ToggleButtons(
                      borderRadius: BorderRadius.circular(25),
                      constraints: const BoxConstraints.expand(width: 150),
                      fillColor: const Color(0xFF00192D),
                      borderColor: Colors.grey[200],
                      isSelected: togglecontroller.selections,
                      onPressed: (int index) {
                        togglecontroller.updateSelection(index);
                      },
                      children: [
                        Container(
                          color: togglecontroller.selections[0]
                              ? const Color(0xFF00192D)
                              : Colors.grey[200],
                          alignment: Alignment.center,
                          child: Text(
                            'Today',
                            style: TextStyle(
                              color: togglecontroller.selections[0]
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          color: togglecontroller.selections[1]
                              ? const Color(0xFF00192D)
                              : Colors.grey[200],
                          alignment: Alignment.center,
                          child: Text(
                            'Total',
                            style: TextStyle(
                              color: togglecontroller.selections[1]
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Consumer<ToggleController>(
                        builder: (context, togglecontroller, child) {
                      return togglecontroller.selections[0]
                          ? const TodayExpense()
                          : const TotalAmount();
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
