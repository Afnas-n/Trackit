class UserExpense {
  final double amount; // Amount spent
  final String category; // Category of the expense
  final String notes; // Notes for the expense
  final DateTime date; // Date of the expense
  final String imagePath; // Path to the image representing the category

  UserExpense({
    required this.amount,
    required this.category,
    required this.notes,
    required this.date,
    required this.imagePath,
  });

  // You can add a factory constructor for creating a UserExpense from a map
  factory UserExpense.fromMap(Map<String, dynamic> map) {
    return UserExpense(
      amount: map['amount'],
      category: map['category'],
      notes: map['notes'],
      date: DateTime.parse(map['date']),
      imagePath: map['imagePath'],
    );
  }

  // Method to convert UserExpense to a map for storage (e.g., in Firestore)
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category,
      'notes': notes,
      'date': date.toIso8601String(),
      'imagePath': imagePath,
    };
  }
}
