import 'package:get/get.dart';

import 'package:expense_tracker_app/app/modules/home/bindings/home_binding.dart';
import 'package:expense_tracker_app/app/modules/home/views/home_view.dart';
import 'package:expense_tracker_app/app/modules/add_expense/bindings/add_expense_binding.dart';
import 'package:expense_tracker_app/app/modules/add_expense/views/add_expense_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EXPENSE,
      page: () => const AddExpenseView(),
      binding: AddExpenseBinding(),
    ),
  ];
}
