import 'package:flutter_application_1/service/setting_firebase.dart';

class Setting {
  bool darkMode;
  String timeFormat;
  String temperatureFormat;

  Setting(
      {required this.darkMode,
      required this.timeFormat,
      required this.temperatureFormat});

  Map<String, dynamic> toJson() => {
        'darkMode': darkMode,
        'timeFormat': timeFormat,
        'temperatureFormat': temperatureFormat,
      };

  Setting.fromJson(Map<String, dynamic>? json)
      : this(
          darkMode: json?['darkMode'],
          timeFormat: json?['timeFormat'],
          temperatureFormat: json?['temperatureFormat'],
        );

  Future createSetting(String userID) async {
    SettingFirebase settingFirebase = SettingFirebase();
    return await settingFirebase.createSetting(this, userID);
  }

  static Future getSetting(String userID) async {
    SettingFirebase settingFirebase = SettingFirebase();
    return await settingFirebase.getSetting(userID);
  }

  Future updateSetting(String userID) async {
    SettingFirebase settingFirebase = SettingFirebase();
    return await settingFirebase.updateSetting(this, userID);
  }
}
