import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
 class DevWidgets {
  static Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'deula.db');
    await deleteDatabase(path);
  }

}
