import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class ModelService {
  List attendaceInfo = ['Date/Time', 'Semester', 'distance', 'Name'];
  List attendaceValue = ['date/time', '8', 38.0, 'Muhammad Jumadi'];
  List campusLocation = ['Kebon Jeruk', 'Harapan Indah'];
  List campusKbj = [-6.174639, 106.954637];
  List campusHi = [-6.174283, 106.949547];
  List campusButton = [false, false];
  List subject = ['Android Dev', 'Database', 'Web Dev'];
  List subjectButton = [false, false, false];
  LatLng pinnedLocation = LatLng(-6.247747, 106.610343);
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}

class MapsService {
  static ModelService _modelService = ModelService();
  LocationData? currentPosition;
  String? dateTime;
  Location location = Location();
  double distance = 0.0;
  double totalDistance = 0;
  LatLng pinnedLocation =
      LatLng(_modelService.campusKbj[0], _modelService.campusKbj[1]);

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentPosition = await location.getLocation();
    LatLng(currentPosition!.latitude!.toDouble(),
        currentPosition!.longitude!.toDouble());
    location.onLocationChanged.listen((LocationData currentLocation) {
      currentPosition = currentLocation;
      LatLng(currentPosition!.latitude!.toDouble(),
          currentPosition!.longitude!.toDouble());

      DateTime now = DateTime.now();
      dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
    });

    totalDistance = _modelService.calculateDistance(
        currentPosition!.latitude,
        currentPosition!.longitude,
        pinnedLocation.latitude,
        pinnedLocation.longitude);

    distance = totalDistance;
  }
}
