import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

import 'list_items.dart';

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'your_database.db'),
      onCreate: (db, version) {
        // Create tables
        db.execute('''
          CREATE TABLE tasks(
            id TEXT PRIMARY KEY,
            title TEXT,
            category TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object?> data) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertTask(Task task) async {
    final db = await DBHelper.database();
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
}
