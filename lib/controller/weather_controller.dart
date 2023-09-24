import 'package:flutter_application_1/service/location_service.dart';
import 'package:flutter_application_1/service/weather_service.dart';
import 'package:flutter_application_1/view/shared/dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather/weather.dart';

class WeatherController extends GetxController {
  Future<Position?> getCurrentPosition() async {
    Position? position = await LocationService.getCurrentPosition();

    return position;
  }

  Future<List<Weather>> getWeatherList() async {
    return await getCurrentPosition().then((value) async {
      if (value == null) {
        return List<Weather>.empty();
      }
      List<Weather> weatherList =
          await WeatherService.getFiveDayForecastByLocation(
              value.latitude, value.longitude);

      return weatherList;
    });
  }

  RxInt weatherIndex = RxInt(0);
}
