import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker_app/app/data/models/expense_model.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;

  const ExpenseCard({Key? key, required this.expense, required this.onDelete})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Get.theme.primaryColor.withOpacity(0.1),
          child: Icon(
            _getCategoryIcon(expense.category),
            color: Get.theme.primaryColor,
            size: 20,
          ),
        ),
        title: Text(
          expense.category,
          style: Get.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          expense.notes ?? 'No notes',
          style: Get.textTheme.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '₹${expense.amount.toStringAsFixed(2)}',
              style: Get.textTheme.bodyLarge?.copyWith(color: Colors.redAccent),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.red[300]),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.fastfood;
      case 'transport':
        return Icons.directions_bus;
      case 'entertainment':
        return Icons.movie;
      case 'shopping':
        return Icons.shopping_bag;
      case 'utilities':
        return Icons.lightbulb;
      case 'health':
        return Icons.medical_services;
      case 'education':
        return Icons.school;
      case 'salary':
        return Icons.attach_money;
      default:
        return Icons.category;
    }
  }
}
