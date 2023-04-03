import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gpt/models/chat_model.dart';
import 'package:pocket_gpt/screen/chat_screen.dart';
import 'package:pocket_gpt/screen/new_chat_screen.dart';
import 'package:pocket_gpt/widget/chat_category_chip_widget.dart';
import 'package:pocket_gpt/widget/chat_summary_widget.dart';
import 'package:pocket_gpt/services/chat_service.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final ChatService _chatService = ChatService();

  String selectedCategory = 'ALL';
  List<Chat> _chatData = [];
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    refresh();
  }

  // 채팅 목록 리프레쉬
  Future<void> refresh() async {
    _fetchChats();
    _fetchCategories();
  }

  // 채팅 리스트 가져오기
  Future<void> _fetchChats() async {
    final chats = await _chatService.getChats();
    setState(() {
      _chatData = chats;
    });
  }

  // 채팅 카테고리 가져오기
  Future<void> _fetchCategories() async {
    final List<String> categories = await _chatService.getCategories();
    setState(() {
      _categories = categories;
    });
  }

  // 신규 채팅 추가 스크린으로 이동
  Future<void> _navigateToNewChatScreen(BuildContext context) async {
    final bool? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewChatScreen(categories: _categories)));

    if (result != null && result) {
      // Fetch the updated chat list if a new chat was created.
      refresh();
    }
  }

  // 채팅 스크린으로 이동
  Future<void> _navigateToChatScreen(BuildContext context, Chat chat) async {
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(
          chat: chat,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ).then((value) {
      refresh();
    });
  }

  // 채팅 삭제
  Future<void> _deleteChat(Chat chat) async {
    int deleteChatId = await _chatService.deleteChat(chat.id as int);

    if (deleteChatId > 0) {
      refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter the chat list based on the selected category
    List<Chat> filteredChatData = _chatData.where((chat) {
      if (selectedCategory == 'ALL') {
        return true;
      }
      return chat.category == selectedCategory;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.search, color: Colors.black),
          onPressed: () {
            // Add functionality for the menu button
          },
        ),
        title: const Text(
          'Chats',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add, color: Colors.black),
            onPressed: () {
              _navigateToNewChatScreen(context);
            },
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: [
                      ChatCatergoryChipWidget(
                        categoryName: 'ALL',
                        isSelected: selectedCategory == 'ALL',
                        onSelected: (bool selected) {
                          setState(() {
                            selectedCategory = selected ? 'ALL' : 'ALL';
                          });
                        },
                      ),
                      for (final category in _categories)
                        ChatCatergoryChipWidget(
                          categoryName: category,
                          isSelected: selectedCategory == category,
                          onSelected: (bool selected) {
                            setState(() {
                              selectedCategory = selected ? category : 'ALL';
                            });
                          },
                        ),
                      // Add more CategoryChip widgets as needed
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey[200],
                thickness: 0.8,
              ),
              itemCount: filteredChatData.length,
              itemBuilder: (BuildContext context, int index) {
                return ChatSummaryWidget(
                    chat: filteredChatData[index],
                    goToChatScreen: _navigateToChatScreen,
                    deleteChat: _deleteChat);
              },
            ),
          ),
        ],
      ),
    );
  }
}
