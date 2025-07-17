import 'package:expense_tracker/local/constants/category_table.dart';

class CategoryModel {
  final int id;
  final String emoji;
  final String name;
  final String createdAt;

  CategoryModel({
    required this.id,
    required this.emoji,
    required this.name,
    required this.createdAt,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map[cId],
      emoji: map[cEmoji],
      name: map[cName],
      createdAt: map[cCreatedAt],
    );
  }
}
