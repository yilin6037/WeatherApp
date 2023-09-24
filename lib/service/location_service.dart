import 'package:flutter_application_1/view/shared/dialog.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<bool> _handleLocationPermission() async {
    // bool serviceEnabled;
    LocationPermission permission;

    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   SharedDialog.alertDialog(
    //       'Location services are disabled.', 'Please enable the services');
    //   return false;
    // }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        SharedDialog.alertDialog(
            'Location permissions are denied', 'Please enable the services');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      SharedDialog.alertDialog(
          'Location permissions are permanently denied, we cannot request permissions.',
          'Please enable the services');
      return false;
    }
    return true;
  }

  static Future<Position?> getCurrentPosition() async {
    return await _handleLocationPermission().then((hasPermission) async {
      Position? position;
      if (!hasPermission) {
        // position = await Geolocator.getLastKnownPosition();
      } else {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
      }
      return position;
    });
  }
}
