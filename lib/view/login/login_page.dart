import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/authentication_controller.dart';
import 'package:flutter_application_1/controller/setting_controller.dart';
import 'package:flutter_application_1/view/home/home_page.dart';
import 'package:flutter_application_1/view/register/register_page.dart';
import 'package:flutter_application_1/view/shared/button.dart';
import 'package:flutter_application_1/view/shared/dialog.dart';
import 'package:flutter_application_1/view/shared/scaffold_no_navbar.dart';
import 'package:flutter_application_1/view/shared/textformfield.dart';
import 'package:flutter_application_1/view/shared/textformfield_validator.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthenticationController authenticationController =
      Get.put(tag: 'authenticationController', AuthenticationController());

  final SettingController settingController =
      Get.put(tag: 'settingController', SettingController());

  @override
  Widget build(BuildContext context) {
    authenticationController.cleanData();
    return SharedScaffoldNoNavbar(
      title: 'Login',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Form(
            key: authenticationController.loginFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SharedTextFormField(
                  controller: authenticationController.emailTextController,
                  labelText: 'Email',
                  hintText: 'Please enter your email',
                  keyboard: TextInputType.emailAddress,
                  validator: ValidatorType.email,
                ),
                SharedTextFormField(
                  controller: authenticationController.passwordTextController,
                  labelText: 'Password',
                  hintText: 'Please enter your password',
                  obscureText: true,
                  validator: ValidatorType.password,
                ),
                SizedBox(
                  height: 30,
                ),
                SharedButton(
                    onPressed: () async {
                      if (authenticationController.loginFormKey.currentState!
                          .validate()) {
                        await authenticationController.login();

                        if (authenticationController.currentUser != null) {
                          await settingController.initSetting();
                          Get.offAll(() => HomePage());
                        } else {
                          SharedDialog.alertDialog(
                              'Login Unsuccessful', Get.find(tag: 'message'));
                        }
                      }
                    },
                    text: 'Login'),
                Text('or'),
                SharedButton(
                    onPressed: () {
                      Get.to(RegisterPage());
                    },
                    text: 'Register')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
