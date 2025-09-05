import 'package:flutter/material.dart';

class CategoryData {
  final String name;
  final IconData icon;
  final Color color;

  CategoryData({required this.name, required this.icon, required this.color});

  static List<CategoryData> get allCategories => [
    CategoryData(name: 'Food', icon: Icons.fastfood, color: Colors.orange),
    CategoryData(
      name: 'Transport',
      icon: Icons.directions_bus,
      color: Colors.blue,
    ),
    CategoryData(
      name: 'Entertainment',
      icon: Icons.movie,
      color: Colors.purple,
    ),
    CategoryData(
      name: 'Shopping',
      icon: Icons.shopping_bag,
      color: Colors.pink,
    ),
    CategoryData(name: 'Utilities', icon: Icons.lightbulb, color: Colors.brown),
    CategoryData(
      name: 'Health',
      icon: Icons.medical_services,
      color: Colors.teal,
    ),
    CategoryData(name: 'Education', icon: Icons.school, color: Colors.amber),
    CategoryData(name: 'Salary', icon: Icons.attach_money, color: Colors.green),
    CategoryData(name: 'Others', icon: Icons.category, color: Colors.grey),
  ];

  static IconData getIcon(String categoryName) {
    return allCategories
        .firstWhere(
          (cat) => cat.name.toLowerCase() == categoryName.toLowerCase(),
          orElse: () =>
              CategoryData(name: '', icon: Icons.category, color: Colors.grey),
        )
        .icon;
  }

  static Color getColor(String categoryName) {
    return allCategories
        .firstWhere(
          (cat) => cat.name.toLowerCase() == categoryName.toLowerCase(),
          orElse: () =>
              CategoryData(name: '', icon: Icons.category, color: Colors.grey),
        )
        .color;
  }
}
