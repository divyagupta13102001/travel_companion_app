import 'dart:io';
import 'package:flutter/foundation.dart';

class location {
  final double lattitude;
  final double longitude;
  final String address;

  location(
      {required this.lattitude,
      required this.longitude,
      required this.address});
}

class Places {
  final String id;
  final String name;
  final File? image;
  final location? place;

  Places(
      {required this.id, required this.name, required this.image, this.place});
}
