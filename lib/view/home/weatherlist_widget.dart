import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/setting_controller.dart';
import 'package:flutter_application_1/controller/weather_controller.dart';
import 'package:flutter_application_1/view/shared/day.dart';
import 'package:get/get.dart';
import 'package:weather/weather.dart';

class WeatherList extends StatelessWidget {
  WeatherList({super.key, required this.weatherList});

  final List<Weather> weatherList;
  final WeatherController weatherController =
      Get.find(tag: 'weatherController');
  final SettingController settingController =
      Get.find(tag: 'settingController');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: weatherList.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          if (weatherList[index].date == null) {
            return const Text('Something went wrong');
          }
          bool printDay = index == 0 ||
              weatherList[index].date!.weekday !=
                  weatherList[index - 1].date!.weekday;
          return Column(
            children: [
              printDay ? Divider() : Container(),
              GestureDetector(
                onTap: () {
                  weatherController.weatherIndex.value = index;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    printDay
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text(
                              Day.values[weatherList[index].date!.weekday - 1]
                                  .short,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                        : SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                          ),
                    settingController.timeFormat.value == '12h'
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.17,
                            child: Text(
                              '${weatherList[index].date!.hour > 12 ? weatherList[index].date!.hour - 12 : weatherList[index].date!.hour}:00 ${weatherList[index].date!.hour >= 12 ? 'PM' : 'AM'}',
                              textAlign: TextAlign.end,
                            ))
                        : SizedBox(
                            width: MediaQuery.of(context).size.width * 0.17,
                            child: Text(
                              '${weatherList[index].date!.hour}:00',
                              textAlign: TextAlign.end,
                            )),
                    settingController.temperatureFormat.value == 'c'
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text(
                              '${weatherList[index].temperature?.celsius?.round().toString() ?? ''}°c',
                              textAlign: TextAlign.end,
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text(
                              '${weatherList[index].temperature?.fahrenheit?.round().toString() ?? ''}°F',
                              textAlign: TextAlign.end,
                            ),
                          ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: Row(
                          children: [
                            weatherList[index].weatherIcon != null
                                ? Image.network(
                                    'http://openweathermap.org/img/w/${weatherList[index].weatherIcon!}.png',
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    fit: BoxFit.fill,
                                  )
                                : Container(),
                            Flexible(
                              child: Text(
                                weatherList[index].weatherMain ?? '',
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
