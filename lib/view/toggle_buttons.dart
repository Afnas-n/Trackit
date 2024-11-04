import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit/controller/toggle_controller.dart';
import 'package:trackit/view/today_expense.dart';
import 'package:trackit/view/total_amount.dart';

class ToggleButtonsWidget extends StatelessWidget {
  const ToggleButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ToggleController>(builder: (context, toggleController, child) {
      return Column(
        children: [
          ToggleButtons(
            borderRadius: BorderRadius.circular(25),
            constraints: const BoxConstraints.expand(width: 150),
            fillColor: const Color(0xFF00192D),
            borderColor: Colors.grey[200],
            isSelected: toggleController.selections,
            onPressed: (int index) {
              toggleController.updateSelection(index);
            },
            children: [
              Container(
                color: toggleController.selections[0] ? const Color(0xFF00192D) : Colors.grey[200],
                alignment: Alignment.center,
                child: Text(
                  'Today',
                  style: TextStyle(color: toggleController.selections[0] ? Colors.white : Colors.black),
                ),
              ),
              Container(
                color: toggleController.selections[1] ? const Color(0xFF00192D) : Colors.grey[200],
                alignment: Alignment.center,
                child: Text(
                  'Total',
                  style: TextStyle(color: toggleController.selections[1] ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: toggleController.selections[0] ? const TodayExpense() : const TotalAmount(),
          ),
        ],
      );
    });
  }
}
