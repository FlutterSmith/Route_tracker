import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<void> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();

    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        throw LocationServiceException();
      }
    }
  }

  Future<void> checkAndRequestLocationPermission() async {
    var isPermissionGranted = await location.hasPermission();

    if (isPermissionGranted == PermissionStatus.deniedForever) {
      throw LocationPermissionException();
    }

    if (isPermissionGranted == PermissionStatus.denied) {
      isPermissionGranted = await location.requestPermission();

      if (isPermissionGranted != PermissionStatus.granted) {
        throw LocationPermissionException();
      }
    }
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    location.onLocationChanged.listen((onData));
  }

  Future<LocationData> getLocation() async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    return await location.getLocation();
  }
}

class LocationServiceException implements Exception {}

class LocationPermissionException implements Exception {}
