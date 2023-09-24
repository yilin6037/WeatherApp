import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/authentication_controller.dart';
import 'package:flutter_application_1/view/login/login_page.dart';
import 'package:flutter_application_1/view/shared/button.dart';
import 'package:flutter_application_1/view/shared/dialog.dart';
import 'package:flutter_application_1/view/shared/scaffold_no_navbar.dart';
import 'package:flutter_application_1/view/shared/textformfield.dart';
import 'package:flutter_application_1/view/shared/textformfield_validator.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final AuthenticationController authenticationController =
      Get.find(tag: 'authenticationController');

  @override
  Widget build(BuildContext context) {
    authenticationController.cleanData();
    return SharedScaffoldNoNavbar(
      title: 'Register',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Form(
            key: authenticationController.registerFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SharedTextFormField(
                  controller: authenticationController.nameTextController,
                  labelText: 'Name',
                  hintText: 'Please enter your name',
                  validator: ValidatorType.required,
                ),
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
                      if (authenticationController.registerFormKey.currentState!
                          .validate()) {
                        await authenticationController.register().then((value) {
                          if (value) {
                            SharedDialog.directDialog(
                                'Register Successful',
                                'Your account is successfully created',
                                LoginPage());
                          } else {
                            SharedDialog.alertDialog(
                                'Register Failed', Get.find(tag: 'message'));
                          }
                        });
                      }
                    },
                    text: 'Register'),
                Text('or'),
                SharedButton(
                    onPressed: () => Get.to(LoginPage()), text: 'Login')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
