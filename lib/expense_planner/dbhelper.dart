import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelperT {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'transactions.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE transactions(id TEXT PRIMARY KEY, title TEXT, amount REAL, date TEXT, category TEXT)',
        );
      },
      version: 1,
    );
  }
  // String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  static Future<void> insertTransaction(
      Map<String, dynamic> transactionMap) async {
    final db = await database();

    // Format the date value before inserting
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(DateTime.parse(transactionMap['date']));
    String formattedId =
        DateFormat('yyyyMMddHHmmss').format(DateTime.now()).toString();

    final updatedTransactionMap = {
      ...transactionMap,
      'id': formattedId,
      'date': formattedDate,
    };

    await db.insert(
      'transactions',
      updatedTransactionMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await database();
    return db.query('transactions');
  }
}
