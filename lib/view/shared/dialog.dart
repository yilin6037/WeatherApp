import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharedDialog {
  static void alertDialog(String title, String message) {
    Get.defaultDialog(
        title: title,
        middleText: message,
        confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Ok')));
  }

  static void errorDialog() {
    alertDialog('Error', 'Something went wrong!');
  }

  static void directDialog(String title, String message, Widget page) {
    Get.defaultDialog(
        title: title,
        middleText: message,
        confirm: TextButton(
            onPressed: () {
              Get.back();
              Get.off(() => page);
            },
            child: Text('Ok')));
  }

  static void confirmationDialog(
      {String title = 'Confirm Dialog',
      String message = 'Are you sure?',
      required Function onOK,
      required Function onCancel}) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      confirm: TextButton(
        onPressed: () {
          Get.back();
          onOK();
        },
        child: Text('Ok'),
      ),
      cancel: TextButton(
          onPressed: () {
            Get.back();
            onCancel();
          },
          child: Text('Cancel')),
    );
  }
}
