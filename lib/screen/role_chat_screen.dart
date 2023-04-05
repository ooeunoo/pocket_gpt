import 'package:flutter/material.dart';
import 'package:pocket_gpt/config/role_chat_category.dart';
import 'package:pocket_gpt/models/role_chat_model.dart';
import 'package:pocket_gpt/services/role_chat_service.dart';

class RoleChatScreen extends StatefulWidget {
  const RoleChatScreen({super.key});

  @override
  State<RoleChatScreen> createState() => _RoleChatScreenState();
}

class _RoleChatScreenState extends State<RoleChatScreen> {
  final RoleChatService _roleChatService = RoleChatService();

  late List<RoleChat> _roleChats;
  late RoleChatCategory _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = RoleChatCategory.Sports;
    _getRoleChats();
  }

  Future<void> _getRoleChats() async {
    List<RoleChat> roleChats =
        await _roleChatService.getRoleChatByCategory(_selectedCategory);
    print(roleChats);
    setState(() {
      _roleChats = roleChats;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'RoleChat',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(children: [
          _buildCategoryList(),
          // Expanded(child: _buildRoleChatList()),
        ]));
  }

  Widget _buildCategoryList() {
    List categories = RoleChatCategory.values
        .map((category) => getRoleChatCategory(category))
        .toList();

    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                _selectedCategory = categories[index];
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                backgroundColor: _selectedCategory == categories[index]
                    ? Colors.blue
                    : Colors.grey,
                child: Text(categories[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget _buildRoleChatList() {
  //   List<RoleChat> filteredRoleChats = _roleChats
  //       .where((element) => element.category == _selectedCategory)
  //       .toList();

  //   return ListView.builder(
  //     itemCount: filteredRoleChats.length,
  //     itemBuilder: (context, index) {
  //       RoleChat roleChat = filteredRoleChats[index];

  //       // if (roleChat.hot) {
  //       //   return _buildHotRoleChatItem(roleChat);
  //       // } else {
  //       return _buildRoleChatItem(roleChat);
  //       // }
  //     },
  //   );
  // }

  // Widget _buildHotRoleChatItem(RoleChat roleChat) {
  //   // Customize this function for hot role chats
  //   return _buildRoleChatItem(roleChat);
  // }

  // Widget _buildRoleChatItem(RoleChat roleChat) {
  //   return ListTile(
  //     leading: Image.network(
  //       'https://example.com/default_image.jpg', // Replace with the default image URL
  //       height: 50,
  //       width: 50,
  //     ),
  //     title: Text(roleChat.title),
  //     subtitle: Text(roleChat.description),
  //     onTap: () {
  //       // Navigate to the chat screen for the selected role
  //     },
  //   );
  // }
}
