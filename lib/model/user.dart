import 'package:flutter_application_1/controller/setting_controller.dart';
import 'package:flutter_application_1/service/firebase_authentication.dart';
import 'package:flutter_application_1/service/user_firebase.dart';
import 'package:get/get.dart';

class User {
  String userID;
  String name;
  String email;

  User({
    this.userID = '',
    this.name = '',
    this.email = '',
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };

  User.fromJson(Map<String, dynamic>? json, String userID)
      : this(name: json?['name'], email: json?['email'], userID: userID);

  static Future<User?> login(String email, String password) async {
    User? user;
    AuthenticationFirebase authenticationFirebase = AuthenticationFirebase();
    final signInResult =
        await authenticationFirebase.signIn(email: email, password: password);

    if (signInResult != null) {
      UserFirebase userFirebase = UserFirebase();
      user = await userFirebase.getUser(signInResult.uid);
    }
    return user;
  }

  Future<bool> register(String password) async {
    AuthenticationFirebase authenticationFirebase = AuthenticationFirebase();
    userID =
        await authenticationFirebase.register(email: email, password: password);

    if (userID == '') {
      return false;
    }

    UserFirebase userFirebase = UserFirebase();
    await userFirebase.createUser(this);

    final SettingController settingController =
      Get.find(tag: 'settingController');
      settingController.createSetting(userID);

    return true;
  }

  static Future logout() async {
    AuthenticationFirebase authenticationFirebase = AuthenticationFirebase();
    return await authenticationFirebase.signOut();
  }

  Future editProfile() async {
    UserFirebase userFirebase = UserFirebase();
    await userFirebase.updateUser(this);
  }
}
