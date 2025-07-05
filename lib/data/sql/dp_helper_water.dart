import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WaterDBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'water_tracker.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE water(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL,
            timestamp TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insertWater(double amount) async {
    final db = await database;
    await db.insert('water', {
      'amount': amount,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  static Future<double> getTotalWater() async {
    final db = await database;
    final result = await db.rawQuery('SELECT SUM(amount) as total FROM water');
    final total = result.first['total'] ?? 0.0;
    return (total as num).toDouble();
  }

  static Future<void> clearAll() async {
    final db = await database;
    await db.delete('water');
  }
}
