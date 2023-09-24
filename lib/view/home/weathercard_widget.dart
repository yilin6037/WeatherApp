import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/setting_controller.dart';
import 'package:get/get.dart';
import 'package:weather/weather.dart';

class WeatherCard extends StatelessWidget {
  WeatherCard({super.key, required this.weather});

  final Weather weather;

  final SettingController settingController =
      Get.find(tag: 'settingController');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Text(
              "${weather.areaName ?? 'Unknown Area'}, ${weather.country ?? 'Unknown Country'}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            settingController.timeFormat.value == '24h'
                ? Text(
                    "${weather.date.toString().substring(0, 16)}",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                : Text(
                    "${weather.date.toString().substring(0, 11)} ${weather.date!.hour > 12 ? weather.date!.hour - 12 : weather.date!.hour}:00 ${weather.date!.hour >= 12 ? 'PM' : 'AM'}",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                //Weather Icon
                weather.weatherIcon != null
                    ? Image.network(
                        'http://openweathermap.org/img/w/${weather.weatherIcon!}.png',
                        width: MediaQuery.of(context).size.width * 0.3,
                        fit: BoxFit.fill,
                      )
                    : Container(),
                SizedBox(
                  width: 20,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //weather
                    Text(
                      '${weather.weatherMain}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    //temperature
                    settingController.temperatureFormat.value == 'c'
                        ? Column(
                            children: [
                              Text(
                                '${weather.temperature?.celsius?.round().toString()}°c',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                              Text(
                                  '${weather.tempMin?.celsius?.round()} ~ ${weather.tempMax?.celsius?.round()} °c'),
                              Text(weather.weatherDescription ?? ''),
                            ],
                          )
                        : Column(
                            children: [
                              Text(
                                '${weather.temperature?.fahrenheit?.round().toString()}°F',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                              Text(
                                  '${weather.tempMin?.fahrenheit?.round()} ~ ${weather.tempMax?.fahrenheit?.round()} °F'),
                              Text(weather.weatherDescription ?? ''),
                            ],
                          ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                //cloud
                Column(
                  children: [
                    Icon(Icons.cloud),
                    Text('${weather.cloudiness}%'),
                  ],
                ),
                //humidity
                Column(
                  children: [
                    Icon(Icons.water_drop),
                    Text('${weather.humidity}%'),
                  ],
                ),
                //wind
                Column(
                  children: [
                    Icon(Icons.air),
                    Text('${weather.windSpeed}m/s'),
                    Text('${weather.windDegree}°'),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
