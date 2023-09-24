import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home/home_page.dart';
import 'package:flutter_application_1/view/setting/setting_page.dart';
import 'package:get/get.dart';

class SharedScaffold extends StatelessWidget {
  const SharedScaffold(
      {super.key,
      required this.body,
      required this.navIndex,
      required this.title,
      this.scrollable = true});

  final Widget body;
  final int navIndex;
  final String title;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false,
      ),
      body: scrollable
          ? SingleChildScrollView(
              child: Center(child: body),
            )
          : body,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navIndex,
        onTap: (value) {
          switch (value) {
            case 0:
              Get.to(HomePage());
              break;
            case 1:
              Get.to(SettingPage());
              break;
            default:
              Get.to(HomePage());
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
