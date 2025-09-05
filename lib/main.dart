import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker_app/app/routes/app_pages.dart';
import 'package:expense_tracker_app/app/core/theme/app_theme.dart';
import 'package:expense_tracker_app/app/data/services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => LocalStorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Expense Tracker",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
