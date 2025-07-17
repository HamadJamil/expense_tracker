import 'package:expense_tracker/local/constants/expense_table.dart';

class ExpenseModel {
  final int id;
  final String name;
  final int amount;
  final int category;
  final String createdAt;

  ExpenseModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.category,
    required this.createdAt,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map[eId],
      name: map[eName],
      amount: map[eAmount],
      category: map[eCategory],
      createdAt: map[eCreatedAt],
    );
  }
}
