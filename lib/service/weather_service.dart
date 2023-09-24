import 'package:weather/weather.dart';

class WeatherService {
  static const _API = '197262e81c582f37f3b17e295ff743d6';
  static final WeatherFactory _wf = WeatherFactory(_API);

  static Future<Weather> getCurrentWeatherByLocation(
      double lat, double lon) async {
    Weather w = await _wf.currentWeatherByLocation(lat, lon);
    return w;
  }

  static Future<List<Weather>> getFiveDayForecastByLocation(
      double lat, double lon) async {
    List<Weather> wList = await _wf.fiveDayForecastByLocation(lat, lon);
    return wList;
  }
}
