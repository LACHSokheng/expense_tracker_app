import 'package:flutter/material.dart'; // Import for AlertDialog
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker_app/app/data/models/expense_model.dart';
import 'package:expense_tracker_app/app/data/services/local_storage_service.dart';
import 'package:expense_tracker_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final LocalStorageService _localStorageService =
      Get.find<LocalStorageService>();

  final RxList<Expense> _allExpenses = <Expense>[].obs;
  final RxList<Expense> displayedExpenses = <Expense>[].obs;
  final Rx<DateTime> selectedMonth = DateTime.now().obs;
  final RxDouble totalMonthlyExpense = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadExpenses();
    ever(_allExpenses, (_) => _filterExpenses());
    ever(selectedMonth, (_) => _filterExpenses());
  }

  void _loadExpenses() {
    _allExpenses.assignAll(_localStorageService.getExpenses());
  }

  void _filterExpenses() {
    final startOfMonth = DateTime(
      selectedMonth.value.year,
      selectedMonth.value.month,
      1,
    );
    final endOfMonth = DateTime(
      selectedMonth.value.year,
      selectedMonth.value.month + 1,
      0,
    );

    displayedExpenses.assignAll(
      _allExpenses.where((expense) {
        return expense.date.isAfter(
              startOfMonth.subtract(const Duration(days: 1)),
            ) &&
            expense.date.isBefore(endOfMonth.add(const Duration(days: 1)));
      }).toList(),
    );
    _calculateTotalMonthlyExpense();
  }

  void _calculateTotalMonthlyExpense() {
    totalMonthlyExpense.value = displayedExpenses.fold(
      0.0,
      (sum, item) => sum + item.amount,
    );
  }

  void previousMonth() {
    selectedMonth.value = DateTime(
      selectedMonth.value.year,
      selectedMonth.value.month - 1,
      1,
    );
  }

  void nextMonth() {
    selectedMonth.value = DateTime(
      selectedMonth.value.year,
      selectedMonth.value.month + 1,
      1,
    );
  }

  void goToAddNewExpense() async {
    await Get.toNamed(Routes.ADD_EXPENSE);
    _loadExpenses(); // Reload expenses after adding a new one
  }

  // --- MODIFIED DELETE EXPENSE ---
  void confirmAndDeleteExpense(String id) {
    Get.defaultDialog(
      title: "Delete Expense",
      middleText: "Are you sure you want to delete this expense?",
      textConfirm: "Delete",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      cancelTextColor: Get.theme.primaryColor,
      buttonColor: Colors.redAccent,
      onConfirm: () async {
        Get.back(); // Close the dialog
        await _localStorageService.deleteExpense(id);
        _loadExpenses(); // Reload expenses after deleting
        Get.snackbar(
          'Deleted!',
          'Expense removed successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      },
      onCancel: () {
        // Do nothing, dialog will just close
      },
    );
  }

  // Group expenses by day for the grid view
  Map<DateTime, List<Expense>> get groupedExpensesByDay {
    Map<DateTime, List<Expense>> grouped = {};
    for (var expense in displayedExpenses) {
      final dateOnly = DateTime(
        expense.date.year,
        expense.date.month,
        expense.date.day,
      );
      if (!grouped.containsKey(dateOnly)) {
        grouped[dateOnly] = [];
      }
      grouped[dateOnly]!.add(expense);
    }
    return grouped;
  }
}
