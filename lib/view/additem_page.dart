import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trackit/controller/datepicker_controller.dart';
import 'package:trackit/controller/dropdown_controller.dart';
import 'package:trackit/controller/expence_controller.dart';
import 'package:intl/intl.dart';

class AdditemPage extends StatelessWidget {
  AdditemPage({super.key});

  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController datepicker = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _selectDate(BuildContext context) async {
    final dateController =
        Provider.of<DatepickerController>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateController.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateController.selectedDate) {
      dateController.updateDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateController = Provider.of<DatepickerController>(context);
    final dropdownController = Provider.of<DropdownController>(context);
    final expenseController =
        Provider.of<ExpenseController>(context, listen: false);

    datepicker.text =
        DateFormat('dd MMMM yyyy').format(dateController.selectedDate);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 80),
              // Amount input field
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 70,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 33, 206, 153),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'INR',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: amountController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        hintText: 'Amount',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d+\.?\d{0,2}')), // Allows digits and up to 2 decimal places
                      ],
                      // Validator to check if the field is empty or invalid
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        try {
                          double.parse(value); // Ensure it's a valid double
                        } catch (e) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Category Dropdown and Image
              Row(
                children: [
                  const SizedBox(width: 20),
                  Consumer<DropdownController>(builder: (context, provider, child) {
                    return Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 207, 246, 234),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Image.asset(
                          provider.getImageForSelectedValue(),
                          width: 40,
                          height: 40,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 20),
                  Consumer<DropdownController>(
                    builder: (context, provider, child) {
                      return SizedBox(
                        width: 220,
                        child: DropdownButtonFormField<String>(
                          value: provider.selectedValue,
                          items: provider.dropdownItemKeys.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              provider.setSelectedValue(newValue);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a category';
                            }
                            return null;
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              // Date Picker
              Row(
                children: [
                  const SizedBox(width: 20),
                  Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 33, 206, 153),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.date_range_outlined,
                        color: Colors.white,
                      )),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 220,
                          child: TextFormField(
                            readOnly: true,
                            onTap: () => _selectDate(context),
                            decoration: const InputDecoration(
                              hintText: "Pick a date",
                            ),
                            controller: datepicker,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Notes input field
              Row(
                children: [
                  const SizedBox(width: 20),
                  Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 33, 206, 153),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.notes,
                        color: Colors.white,
                      )),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 220,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Notes",
                      ),
                      controller: noteController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              // Save button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 33, 206, 153),
                    minimumSize: const Size(180, 40)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save the expense
                    expenseController.addExpense(
                      dropdownController.selectedValue,
                      dropdownController.getImageForSelectedValue(),
                      double.parse(amountController.text), // Handle double
                      noteController.text,
                      dateController.selectedDate,
                    );

                    // Clear the input fields
                    amountController.clear();
                    noteController.clear();
                    datepicker.clear();

                    // Dismiss the keyboard
                    FocusScope.of(context).unfocus();

                    // Optionally, show a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Expense added successfully!')),
                    );
                  }
                },
                child:
                    const Text("Save", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
