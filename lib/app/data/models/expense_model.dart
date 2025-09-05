import 'dart:convert';

class Expense {
  String id;
  double amount;
  String category;
  DateTime date;
  String? notes;

  Expense({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    this.notes,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      amount: json['amount'],
      category: json['category'],
      date: DateTime.parse(json['date']),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }

  // Helper to convert list of expenses to JSON string
  static String encode(List<Expense> expenses) => json.encode(
    expenses.map<Map<String, dynamic>>((expense) => expense.toJson()).toList(),
  );

  // Helper to convert JSON string to list of expenses
  static List<Expense> decode(String expensesString) =>
      (json.decode(expensesString) as List<dynamic>)
          .map<Expense>((item) => Expense.fromJson(item))
          .toList();
}
