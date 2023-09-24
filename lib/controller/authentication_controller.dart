import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/view/login/login_page.dart';
import 'package:flutter_application_1/view/shared/dialog.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  User? currentUser;

  Future login() async {
    Get.put('', tag: 'message');
    currentUser =
        await User.login(emailTextController.text, passwordTextController.text);
  }

  Future<bool> register() async {
    Get.put('', tag: 'message');
    User user =
        User(name: nameTextController.text, email: emailTextController.text);
    return await user.register(passwordTextController.text);
  }

  void cleanData() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    nameTextController = TextEditingController();
    loginFormKey = GlobalKey<FormState>();
    registerFormKey = GlobalKey<FormState>();
  }

  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();

  void initSetting() {
    emailTextController = TextEditingController(text: currentUser!.email);
    nameTextController = TextEditingController(text: currentUser!.name);
    editProfileFormKey = GlobalKey<FormState>();
  }

  Future editProfile() async {
    User user = User(
        userID: currentUser!.userID,
        email: emailTextController.text,
        name: nameTextController.text);

    return await user.editProfile().then((value) => currentUser = user);
  }

  Future logout() async {
    dynamic result = await User.logout();
    currentUser = null;
    if (result == null) {
      cleanData();
      SharedDialog.directDialog(
          'You have been logged out', 'Please login again.', LoginPage());
    } else {
      return result;
    }
  }
}
