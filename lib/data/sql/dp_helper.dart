import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class DBHelper {
  static Database? _db;

  static const String tableMeal = "meals";

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'deula.db');

    return await openDatabase(
      path,
      version: 2, // 👈 bump version number
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        // No destructive action by default
      },
    );
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableMeal (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        calories REAL,
        protein REAL,
        fat REAL,
        sugar REAL,
        date TEXT
      )
    ''');
    print("✅ meals table created");
  }

  static Future<int> insertMeal(Map<String, dynamic> data) async {
    final db = await database;
    data['date'] = DateTime.now().toIso8601String(); // Always set to now
    return await db.insert(tableMeal, data);
  }

  static Future<List<Map<String, dynamic>>> getMeals() async {
    final db = await database;
    return await db.query(tableMeal, orderBy: 'date DESC');
  }

  static Future<List<Map<String, dynamic>>> getTodayMeals() async {
    final db = await database;
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final end = start.add(Duration(days: 1));
    return await db.query(
      tableMeal,
      where: 'date >= ? AND date < ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
      orderBy: 'date DESC',
    );
  }

  static Future<List<Map<String, dynamic>>> getWeekMeals() async {
    final db = await database;
    final now = DateTime.now();
    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day - (now.weekday - 1),
    );
    final endOfWeek = startOfWeek.add(Duration(days: 7));
    return await db.query(
      tableMeal,
      where: 'date >= ? AND date < ?',
      whereArgs: [startOfWeek.toIso8601String(), endOfWeek.toIso8601String()],
      orderBy: 'date DESC',
    );
  }

  static Future<List<Map<String, dynamic>>> getMonthMeals() async {
    final db = await database;
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfNextMonth = (now.month < 12)
        ? DateTime(now.year, now.month + 1, 1)
        : DateTime(now.year + 1, 1, 1);

    return await db.query(
      tableMeal,
      where: 'date >= ? AND date < ?',
      whereArgs: [
        startOfMonth.toIso8601String(),
        startOfNextMonth.toIso8601String(),
      ],
      orderBy: 'date DESC',
    );
  }

  static Future<int> deleteMeal(int id) async {
    final db = await database;
    return await db.delete(tableMeal, where: 'id = ?', whereArgs: [id]);
  }
}
