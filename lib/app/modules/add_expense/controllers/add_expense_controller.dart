import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:expense_tracker_app/app/data/models/expense_model.dart';
import 'package:expense_tracker_app/app/data/services/local_storage_service.dart';
import 'package:expense_tracker_app/app/core/utils/category_data.dart'; // Import the new utility

class AddExpenseController extends GetxController {
  final LocalStorageService _localStorageService =
      Get.find<LocalStorageService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // Initialize with the first category from our list
  final RxString selectedCategory = CategoryData.allCategories.first.name.obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  // Use the list from CategoryData
  final List<String> categories = CategoryData.allCategories
      .map((e) => e.name)
      .toList();

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
      builder: (context, child) {
        return Theme(
          data: Get.theme.copyWith(
            colorScheme: ColorScheme.light(
              primary: Get.theme.primaryColor, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Get.theme.primaryColor, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  Future<void> saveExpense() async {
    if (formKey.currentState!.validate()) {
      final newExpense = Expense(
        id: const Uuid().v4(),
        amount: double.parse(amountController.text),
        category: selectedCategory.value,
        date: selectedDate.value,
        notes: notesController.text.isNotEmpty ? notesController.text : null,
      );

      await _localStorageService.addExpense(newExpense);
      Get.back();
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
