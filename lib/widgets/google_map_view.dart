import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_tracker/utils/location_service.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  late CameraPosition initialCameraPosition;
  late LocationService locationService;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(
        30.966864229441754,
        31.235009913727115,
      ),
      zoom: 0,
    );
    locationService = LocationService();
    updateCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: initialCameraPosition);
  }

  void updateCurrentLocation() async {
    try {
      var locationData = await locationService.getLocation();
    } on LocationServiceException catch (e) {
      // TODO
    } on LocationPermissionException catch (e) {
      // TODO
    } catch (e) {
      // TODO
    }
  }
}
