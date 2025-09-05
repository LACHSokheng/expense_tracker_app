import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker_app/app/data/models/expense_model.dart';

class LocalStorageService extends GetxService {
  late SharedPreferences _prefs;
  static const String _expensesKey = 'expenses';

  Future<LocalStorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  List<Expense> getExpenses() {
    final String? expensesString = _prefs.getString(_expensesKey);
    if (expensesString == null) {
      return [];
    }
    return Expense.decode(expensesString);
  }

  Future<void> saveExpenses(List<Expense> expenses) async {
    final String expensesString = Expense.encode(expenses);
    await _prefs.setString(_expensesKey, expensesString);
  }

  Future<void> addExpense(Expense expense) async {
    final List<Expense> currentExpenses = getExpenses();
    currentExpenses.add(expense);
    await saveExpenses(currentExpenses);
  }

  Future<void> deleteExpense(String id) async {
    final List<Expense> currentExpenses = getExpenses();
    currentExpenses.removeWhere((expense) => expense.id == id);
    await saveExpenses(currentExpenses);
  }
}
