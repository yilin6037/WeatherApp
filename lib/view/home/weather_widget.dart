import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/weather_controller.dart';
import 'package:flutter_application_1/view/home/weathercard_widget.dart';
import 'package:flutter_application_1/view/home/weatherlist_widget.dart';
import 'package:flutter_application_1/view/shared/day.dart';
import 'package:get/get.dart';
import 'package:weather/weather.dart';

class WeatherWidget extends StatelessWidget {
  WeatherWidget({super.key});

  final WeatherController weatherController =
      Get.put(tag: 'weatherController', WeatherController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Weather>>(
        future: weatherController.getWeatherList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          List<Weather> weatherList = snapshot.data!;
          if (weatherList.isEmpty) {
            return Center(
              child: Text('Something went wrong'),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => WeatherCard(
                  weather: weatherList[weatherController.weatherIndex.value])),
              Flexible(
                child: WeatherList(
                  weatherList: weatherList,
                ),
              )
            ],
          );
        });
  }
}
