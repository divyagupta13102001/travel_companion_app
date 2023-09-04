import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelperD {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'documents.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE documents(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, category TEXT, path TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertDocument(Map<String, dynamic> documentMap) async {
    final db = await database();
    await db.insert(
      'documents',
      documentMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getDocuments() async {
    final db = await database();
    return db.query('documents');
  }

  static Future<void> deleteDocument(String documentPath) async {
    final db = await database();
    await db.delete('documents', where: 'path = ?', whereArgs: [documentPath]);
  }
}
