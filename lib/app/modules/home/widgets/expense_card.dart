import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker_app/app/data/models/expense_model.dart';
import 'package:expense_tracker_app/app/core/utils/category_data.dart'; // Import the new utility

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDeleteConfirmed;

  const ExpenseCard({
    Key? key,
    required this.expense,
    required this.onDeleteConfirmed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: CategoryData.getColor(
            expense.category,
          ).withOpacity(0.1), // Use CategoryData
          child: Icon(
            CategoryData.getIcon(expense.category), // Use CategoryData
            color: CategoryData.getColor(expense.category), // Use CategoryData
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
              '៛${expense.amount.toStringAsFixed(2)}',
              style: Get.textTheme.bodyLarge?.copyWith(color: Colors.redAccent),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.red[300]),
              onPressed: onDeleteConfirmed,
            ),
          ],
        ),
      ),
    );
  }
}
