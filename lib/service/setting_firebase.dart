import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/setting.dart';
import 'package:flutter_application_1/model/user.dart';

class SettingFirebase {
  final firestoreInstance = FirebaseFirestore.instance;

  Future createSetting(Setting setting, String userID) async {
    return await firestoreInstance
        .collection('Setting')
        .doc(userID)
        .set(setting.toJson());
  }

  Future<Setting> getSetting(String userID) async {
    Setting setting;

    final snapshot =
        await FirebaseFirestore.instance.collection('Setting').doc(userID).get();
    setting = Setting.fromJson(snapshot.data());

    return setting;
  }

  Future updateSetting(Setting setting, String userID) async {
    return await firestoreInstance
        .collection('Setting')
        .doc(userID)
        .update(setting.toJson());
  }
}
