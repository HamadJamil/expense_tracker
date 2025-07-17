import 'dart:io';

import 'package:expense_tracker/local/constants/category_table.dart';
import 'package:expense_tracker/local/constants/expense_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static DatabaseHelper getInstance = DatabaseHelper._();

  Database? _database;

  Future<Database> getDatabase() async {
    _database ??= await openDataBase();
    return _database!;
  }

  Future<Database> openDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}/database.db";

    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $cTableName ('
          '$cId INTEGER PRIMARY KEY AUTOINCREMENT, '
          '$cEmoji TEXT, '
          '$cName TEXT UNIQUE, '
          '$cCreatedAt TEXT'
          ')',
        );

        await db.execute(
          'CREATE TABLE $eTableName ('
          '$eId INTEGER PRIMARY KEY AUTOINCREMENT, '
          '$eName TEXT, '
          '$eAmount INTEGER, '
          '$eCategory INTEGER, '
          '$eCreatedAt TEXT, '
          'FOREIGN KEY ($eCategory) REFERENCES $cTableName($cId) ON DELETE CASCADE'
          ')',
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    var db = await getDatabase();
    return await db.query(cTableName);
  }

  Future<List<Map<String, dynamic>>> getExpenses(int categoryId) async {
    var db = await getDatabase();
    return await db.query(eTableName, where: '$eCategory = $categoryId');
  }

  Future<bool> addCategory({
    required String emoji,
    required String name,
  }) async {
    var db = await getDatabase();
    var result = await db.insert(cTableName, {
      cEmoji: emoji,
      cName: name,
      cCreatedAt:
          '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
    });
    return result > 0;
  }

  Future<bool> updateCategory({
    required int id,
    required String emoji,
    required String name,
  }) async {
    var db = await getDatabase();
    var result = await db.update(cTableName, {
      cEmoji: emoji,
      cName: name,
    }, where: '$cId = $id');
    return result > 0;
  }

  Future<bool> deleteCategory(int id) async {
    var db = await getDatabase();
    return await db.delete(cTableName, where: '$cId = $id') > 0;
  }

  Future<bool> addExpense({
    required String name,
    required int category,
    required int amount,
  }) async {
    var db = await getDatabase();
    var result = await db.insert(eTableName, {
      eName: name,
      eCategory: category,
      eAmount: amount,
      eCreatedAt:
          '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
    });
    return result > 0;
  }

  Future<bool> updateExpense({
    required int id,
    required int amount,
    required String name,
  }) async {
    var db = await getDatabase();
    var result = await db.update(eTableName, {
      eAmount: amount,
      eName: name,
    }, where: '$eId = $id');
    return result > 0;
  }

  Future<bool> deleteExpense({required int id}) async {
    var db = await getDatabase();
    return await db.delete(eTableName, where: '$eId = $id') > 0;
  }
}
