import 'package:flutter/material.dart';

class SharedScaffoldNoNavbar extends StatelessWidget {
  const SharedScaffoldNoNavbar(
      {super.key, required this.body, required this.title});

  final Widget body;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(child: body),
    );
  }
}
