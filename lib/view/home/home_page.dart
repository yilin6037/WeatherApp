import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home/weather_widget.dart';
import 'package:flutter_application_1/view/shared/scaffold.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SharedScaffold(
      navIndex: 0,
      title: 'Weather Forecast',
      scrollable: false,
      body: WeatherWidget(),
    );
  }
}
