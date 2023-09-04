import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trip_planner/tripPlan/models/tripModel.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'trips.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE trips(id TEXT PRIMARY KEY, title TEXT, start_date TEXT, end_date TEXT, type TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertTrip(Trip trip) async {
    final db = await database();
    await db.insert(
      'trips',
      {
        'id': trip.id,
        'title': trip.title,
        'start_date': trip.startDate.toIso8601String(),
        'end_date': trip.endDate.toIso8601String(),
        'type': trip.type,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getTrips() async {
    final db = await database();
    return db.query('trips');
  }
}
