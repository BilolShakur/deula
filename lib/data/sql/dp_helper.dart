import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dart:io';

class DBHelper {
  static Database? _db;

  static const String tableMeal = "meals";

  static Future<Database> get database async {
    if (_db != null) return _db!;
    return await _initDB();
  }

  static Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'deula.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableMeal (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        calories REAL,
        protein REAL,
        fat REAL,
        sugar REAL
      )
    ''');
  }

  // Insert
  static Future<int> insertMeal(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(tableMeal, data);
  }

  // Get all
  static Future<List<Map<String, dynamic>>> getMeals() async {
    final db = await database;
    return await db.query(tableMeal);
  }

  // Delete
  static Future<int> deleteMeal(int id) async {
    final db = await database;
    return await db.delete(tableMeal, where: 'id = ?', whereArgs: [id]);
  }
}
