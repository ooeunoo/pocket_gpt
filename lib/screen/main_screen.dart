import 'package:flutter/material.dart';
import 'package:pocket_gpt/models/chat_model.dart';
import 'package:pocket_gpt/screen/new_chat_screen.dart';
import 'package:pocket_gpt/widget/chat_category_chip_widget.dart';
import 'package:pocket_gpt/widget/chat_summary_widget.dart';
import 'package:pocket_gpt/services/chat_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ChatService _chatService = ChatService();

  String selectedCategory = 'ALL';
  List<Chat> _chatData = [];
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchChats();
    _fetchCategories();
  }

  Future<void> _fetchChats() async {
    final chats = await _chatService.getChats();
    setState(() {
      _chatData = chats;
    });
  }

  Future<void> _fetchCategories() async {
    final List<String> categories = await _chatService.getCategories();
    setState(() {
      _categories = categories;
    });
  }

  void _navigateToNewChatScreen(BuildContext context) async {
    final bool? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewChatScreen(categories: _categories)));

    if (result != null && result) {
      // Fetch the updated chat list if a new chat was created.
      _fetchChats();
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
          icon: const Icon(Icons.menu, color: Colors.black),
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
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Add functionality for the search button
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
            child: ListView.builder(
              itemCount: filteredChatData.length,
              itemBuilder: (BuildContext context, int index) {
                return ChatSummaryWidget(
                  id: filteredChatData[index].id as int,
                  imageUrl: filteredChatData[index].imageUrl,
                  title: filteredChatData[index].title,
                  message: filteredChatData[index].lastMessage?.data,
                  lastChatTime:
                      filteredChatData[index].getLastChatTimeString() != null
                          ? DateTime.parse(
                              filteredChatData[index].getLastChatTimeString()!)
                          : null,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 50.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                _navigateToNewChatScreen(context);
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
