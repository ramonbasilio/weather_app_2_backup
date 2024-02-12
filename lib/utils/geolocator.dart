// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:geolocator/geolocator.dart';

class GeolocatorClass {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      return Future.error('Location services are denied.');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await _geolocatorPlatform.getCurrentPosition();
  }
}
