import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trip_planner/great_places/helpers/db_helpers.dart';
import 'package:trip_planner/great_places/models/places.dart';

class greatPlaces with ChangeNotifier {
  List<Places> _items = [];

  List<Places> get items {
    return [..._items];
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    final newPlace = Places(
      id: DateTime.now().toString(),
      image: pickedImage,
      name: pickedTitle,
      place: null,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.name,
      'image': newPlace.image!.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Places(
            id: item['id'],
            name: item['title'],
            image: File(item['image']),
            place: null,
          ),
        )
        .toList();
    notifyListeners();
  }
}
