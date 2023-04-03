import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gpt/screen/chat_list_screen.dart';
import 'package:pocket_gpt/screen/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ChatListScreen(),
    const Text('Scrap'),
    const SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.chat_bubble,
              size: 28,
            ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.archivebox,
              size: 28,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.settings,
              size: 28,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
