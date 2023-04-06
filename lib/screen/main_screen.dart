import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gpt/screen/chat_list_screen.dart';
import 'package:pocket_gpt/screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ChatListScreen(),
    const RoleChatScreen(),
    const Text('Scrap'),
    const Text('Scrap'),
  ];

  @override
  Widget build(BuildContext context) {
    // 테마
    ThemeData theme = Theme.of(context);

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
        backgroundColor: theme.primaryColor,
        selectedItemColor: theme.colorScheme.secondary,
        unselectedItemColor: theme.tabBarTheme.unselectedLabelColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.chat_bubble,
              size: 28,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.tray_full,
              size: 28,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.viewfinder,
              size: 28,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.profile_circled,
              size: 28,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
