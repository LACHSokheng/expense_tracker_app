import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker_app/app/data/models/expense_model.dart';
import 'package:expense_tracker_app/app/modules/home/widgets/expense_card.dart';

class DailyExpenseGrid extends StatelessWidget {
  final Map<DateTime, List<Expense>> groupedExpenses;
  final Function(String) onDelete;

  const DailyExpenseGrid({
    Key? key,
    required this.groupedExpenses,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedDates = groupedExpenses.keys.toList()
      ..sort((a, b) => b.compareTo(a)); // Sort in descending order

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final date = sortedDates[index];
        final expenses = groupedExpenses[date]!;
        final dailyTotal = expenses.fold(0.0, (sum, item) => sum + item.amount);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('EEEE, MMM d').format(date),
                    style: Get.textTheme.headlineSmall,
                  ),
                  Text(
                    'Daily: ៛${dailyTotal.toStringAsFixed(2)}', // Updated currency
                    style: Get.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            ...expenses.map(
              (expense) => ExpenseCard(
                expense: expense,
                onDeleteConfirmed: () =>
                    onDelete(expense.id), // Corrected callback
              ),
            ),
            const Divider(), // Separator between days
          ],
        );
      },
    );
  }
}
