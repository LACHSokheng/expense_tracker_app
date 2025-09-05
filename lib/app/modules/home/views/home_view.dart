import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';
import '../widgets/daily_expense_grid.dart'; // We will create this
import '../widgets/expense_card.dart'; // We will create this

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracker')),
      body: Column(
        children: [
          _buildMonthSelector(),
          _buildTotalMonthlyExpense(),
          Expanded(
            child: Obx(() {
              if (controller.displayedExpenses.isEmpty) {
                return Center(
                  child: Text(
                    "No expenses for ${DateFormat('MMMM yyyy').format(controller.selectedMonth.value)}",
                    style: Get.textTheme.bodyLarge,
                  ),
                );
              }
              return DailyExpenseGrid(
                groupedExpenses: controller.groupedExpensesByDay,
                onDelete: controller.confirmAndDeleteExpense,
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToAddNewExpense,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: controller.previousMonth,
          ),
          Obx(
            () => Text(
              DateFormat('MMMM yyyy').format(controller.selectedMonth.value),
              style: Get.textTheme.headlineSmall,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: controller.nextMonth,
          ),
        ],
      ),
    );
  }

  Widget _buildTotalMonthlyExpense() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Get.theme.primaryColor.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Monthly Expenses:',
                  style: Get.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${controller.totalMonthlyExpense.value.toStringAsFixed(2)}៛', // Assuming INR, adjust as needed
                  style: Get.textTheme.headlineSmall?.copyWith(
                    color: Get.theme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
