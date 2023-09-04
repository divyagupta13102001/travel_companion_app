import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationProvider with ChangeNotifier {
  Position? _position;
  String? _address;

  Position? get position => _position;
  String? get address => _address;

  Future<void> getCurrentLocation() async {
    if (await Permission.location.isGranted) {
      _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (_position != null) {
        _address = await _getAddress(_position!);
      }
    } else {
      await Permission.location.request();
    }

    notifyListeners();
  }

  Future<String> _getAddress(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      return '${placemark.street}, ${placemark.locality}, ${placemark.country}';
    } else {
      return 'Address not found';
    }
  }
}
