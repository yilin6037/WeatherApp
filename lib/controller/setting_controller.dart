import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/authentication_controller.dart';
import 'package:flutter_application_1/model/setting.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final AuthenticationController authenticationController =
      Get.find(tag: 'authenticationController');

  RxBool darkMode = RxBool(Get.isDarkMode);
  RxString timeFormat = RxString('24h');
  RxString temperatureFormat = RxString('c');

  Future createSetting(String userID) async {
    Setting setting = Setting(
        darkMode: darkMode.value,
        timeFormat: timeFormat.value,
        temperatureFormat: temperatureFormat.value);

    return await setting.createSetting(userID);
  }

  Future initSetting() async {
    Setting setting =
        await Setting.getSetting(authenticationController.currentUser!.userID);
    darkMode.value = setting.darkMode;
    Get.changeThemeMode(darkMode.value ? ThemeMode.dark : ThemeMode.light);
    timeFormat.value = setting.timeFormat;
    temperatureFormat.value = setting.temperatureFormat;
  }

  Future updateSetting() async {
    Setting setting = Setting(
        darkMode: darkMode.value,
        timeFormat: timeFormat.value,
        temperatureFormat: temperatureFormat.value);

    return await setting
        .updateSetting(authenticationController.currentUser!.userID)
        .then((value) async => await initSetting());
  }
}
