import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart'; // Add uuid package to pubspec.yaml
import 'package:expense_tracker_app/app/data/models/expense_model.dart';
import 'package:expense_tracker_app/app/data/services/local_storage_service.dart';

class AddExpenseController extends GetxController {
  final LocalStorageService _localStorageService =
      Get.find<LocalStorageService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final RxString selectedCategory = 'Food'.obs; // Default category
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  final List<String> categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Shopping',
    'Utilities',
    'Health',
    'Education',
    'Salary', // For income if you want to track it
    'Others',
  ];

  @override
  void onClose() {
    amountController.dispose();
    notesController.dispose();
    super.onClose();
  }

  void chooseCategory(String? category) {
    if (category != null) {
      selectedCategory.value = category;
    }
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  Future<void> saveExpense() async {
    if (formKey.currentState!.validate()) {
      final newExpense = Expense(
        id: const Uuid().v4(), // Generate a unique ID
        amount: double.parse(amountController.text),
        category: selectedCategory.value,
        date: selectedDate.value,
        notes: notesController.text.isNotEmpty ? notesController.text : null,
      );

      await _localStorageService.addExpense(newExpense);
      Get.back(); // Go back to the home screen
      Get.snackbar(
        'Success',
        'Expense added successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }
}
