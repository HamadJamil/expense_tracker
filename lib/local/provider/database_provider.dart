import 'package:expense_tracker/local/database/database_helper.dart';
import 'package:expense_tracker/model/category_model.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.getInstance;

  List<CategoryModel> _categories = [];
  List<ExpenseModel> _expenses = [];
  String _emoji = '🍔';

  List<CategoryModel> get categories => _categories;
  List<ExpenseModel> get expenses => _expenses;

  void setEmoji(String emoji) {
    _emoji = emoji;
    notifyListeners();
  }

  Future<void> loadCategories() async {
    final data = await _dbHelper.getCategories();
    _categories = data.map((e) => CategoryModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> loadExpenses(int categoryId) async {
    final data = await _dbHelper.getExpenses(categoryId);
    _expenses = data.map((e) => ExpenseModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<bool> addCategory(String emoji, String name) async {
    final success = await _dbHelper.addCategory(emoji: emoji, name: name);
    if (success) {
      await loadCategories();
    }
    return success;
  }

  Future<bool> updateCategory(int id, String emoji, String name) async {
    final success = await _dbHelper.updateCategory(
      id: id,
      emoji: emoji,
      name: name,
    );
    if (success) {
      await loadCategories();
    }
    return success;
  }

  Future<bool> deleteCategory(int id) async {
    final success = await _dbHelper.deleteCategory(id);
    if (success) {
      await loadCategories();
    }
    return success;
  }

  Future<bool> addExpense(String name, int amount, int categoryId) async {
    final success = await _dbHelper.addExpense(
      name: name,
      amount: amount,
      category: categoryId,
    );
    if (success) {
      await loadExpenses(categoryId);
    }
    return success;
  }

  Future<bool> updateExpense(
    int id,
    String name,
    int amount,
    int categoryId,
  ) async {
    final success = await _dbHelper.updateExpense(
      id: id,
      name: name,
      amount: amount,
    );
    if (success) {
      await loadExpenses(categoryId);
    }
    return success;
  }

  Future<bool> deleteExpense(int id, int categoryId) async {
    final success = await _dbHelper.deleteExpense(id: id);
    if (success) {
      await loadExpenses(categoryId);
    }
    return success;
  }
}
