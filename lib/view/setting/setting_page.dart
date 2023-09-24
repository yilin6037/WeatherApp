import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/authentication_controller.dart';
import 'package:flutter_application_1/controller/setting_controller.dart';
import 'package:flutter_application_1/view/shared/button.dart';
import 'package:flutter_application_1/view/shared/dialog.dart';
import 'package:flutter_application_1/view/shared/scaffold.dart';
import 'package:flutter_application_1/view/shared/textformfield.dart';
import 'package:flutter_application_1/view/shared/textformfield_validator.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final AuthenticationController authenticationController =
      Get.find(tag: 'authenticationController');
  final SettingController settingController =
      Get.find(tag: 'settingController');

  @override
  Widget build(BuildContext context) {
    authenticationController.initSetting();
    return SharedScaffold(
      navIndex: 1,
      title: 'Setting',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "User Profile",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Form(
              key: authenticationController.editProfileFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Card(
                child: Column(
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
                      enabled: false,
                    ),
                    SharedButton(
                        onPressed: () async {
                          if (authenticationController
                              .editProfileFormKey.currentState!
                              .validate()) {
                            await authenticationController.editProfile().then(
                                (value) => SharedDialog.alertDialog(
                                    'Edit Successful',
                                    'Your profile is successfully edited'));
                          }
                        },
                        text: 'Save'),
                    SharedButton(
                      onPressed: () async {
                        await authenticationController.logout().then((value) {
                          if (value != null) {
                            SharedDialog.alertDialog('Error', value);
                          }
                        });
                      },
                      text: 'Logout',
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "App Setting",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Obx(() => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Dark Mode'),
                            Switch(
                                value: settingController.darkMode.value,
                                onChanged: (value) async {
                                  settingController.darkMode.value = value;
                                  Get.changeThemeMode(
                                      value ? ThemeMode.dark : ThemeMode.light);
                                  await settingController.updateSetting();
                                }),
                          ],
                        ),
                        Divider(),
                        RadioListTile<String>(
                            title: Text('01:00 PM'),
                            value: '12h',
                            groupValue: settingController.timeFormat.value,
                            onChanged: (value) async {
                              settingController.timeFormat.value = value!;
                              await settingController.updateSetting();
                            }),
                        RadioListTile<String>(
                            title: Text('13:00'),
                            value: '24h',
                            groupValue: settingController.timeFormat.value,
                            onChanged: (value) async {
                              settingController.timeFormat.value = value!;
                              await settingController.updateSetting();
                            }),
                        Divider(),
                        RadioListTile<String>(
                            title: Text('Celcius'),
                            value: 'c',
                            groupValue:
                                settingController.temperatureFormat.value,
                            onChanged: (value) async {
                              settingController.temperatureFormat.value =
                                  value!;
                              await settingController.updateSetting();
                            }),
                        RadioListTile<String>(
                            title: Text('Fahrenheit'),
                            value: 'f',
                            groupValue:
                                settingController.temperatureFormat.value,
                            onChanged: (value) async {
                              settingController.temperatureFormat.value =
                                  value!;
                              await settingController.updateSetting();
                            }),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
