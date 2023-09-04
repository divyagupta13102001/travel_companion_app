import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/db_helpers.dart';
import '../models/tripModel.dart';

class TripProvider extends ChangeNotifier {
  List<Trip> _trips = [];

  List<Trip> get trips => _trips;

  Trip? _mostRecentTrip;
  Trip? get mostRecentTrip => _mostRecentTrip;

  Map<String, String> categoryColors = {
    'Select Value':
        'https://img.freepik.com/free-vector/planning-summer-vacation-leisure-trip-suitcase-map-plane-tickets-top-view-travel-tourism-illustration_1284-52974.jpg?w=2000',
    'Beach':
        'https://img.freepik.com/premium-vector/summer-tropical-sea-beach-background-vector-illustration_175838-2393.jpg',
    'Mountains':
        'https://img.freepik.com/premium-vector/lake-mountain-landscape-free-vector-flat-design_506973-4.jpg?w=2000',
    'Forest':
        'https://img.freepik.com/premium-photo/2d-blank-nature-forest-landscape-scene-cartoon-background_947967-417.jpg',
    'City':
        'https://i.pinimg.com/736x/ca/ab/7b/caab7be087ef0782f307f8971319df64.jpg',
    'Pilgrim':
        'https://img.freepik.com/free-vector/people-with-face-mask-hajj-pilgrimage-illustration_23-2148971411.jpg?w=2000',
  };
  Future<void> addTrip(
      String title, DateTime startDate, DateTime endDate, String type) async {
    String backgroundImageUrl = categoryColors[type] ?? '';
    final newTrip = Trip(
      id: DateTime.now().toString(),
      title: title,
      startDate: startDate,
      endDate: endDate,
      type: type,
      backgroundImageUrl: backgroundImageUrl,
    );
    _mostRecentTrip = Trip(
      id: DateTime.now().toString(),
      title: title,
      startDate: startDate,
      endDate: endDate,
      type: type,
      backgroundImageUrl: backgroundImageUrl,
    );

    notifyListeners();

    await DBHelper.insertTrip(newTrip);
    _trips.add(newTrip);
    notifyListeners();
  }

  Future<void> fetchAndSetTrips() async {
    final dataList = await DBHelper.getTrips();
    _trips = dataList
        .map((item) => Trip(
              id: item['id'],
              title: item['title'],
              startDate: DateTime.parse(item['start_date']),
              endDate: DateTime.parse(item['end_date']),
              type: item['type'],
              backgroundImageUrl: item['backgroundImageUrl'],
            ))
        .toList();
    notifyListeners();
  }
}
