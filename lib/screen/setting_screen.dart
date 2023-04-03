import "package:flutter/material.dart";

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(children: [
          Container(
              alignment: Alignment.center,
              child: Row(
                children: const [],
              ))
        ]));
  }
}
