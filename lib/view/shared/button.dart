import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharedButton extends StatelessWidget {
  const SharedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.width = 150,
      this.fontSize = 20,
      this.height});
  final Function() onPressed;
  final String text;
  final double width;
  final double fontSize;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize:
              height != null ? Size(width, height!) : Size.fromWidth(width),
              backgroundColor: Get.theme.primaryColor
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
          textAlign: TextAlign.center,
        ));
  }
}
