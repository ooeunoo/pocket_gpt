import 'package:flutter/material.dart';
import 'package:pocket_gpt/widget/chat_category_chip_widget.dart';
import 'package:pocket_gpt/widget/chat_summary_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedCategory = 'ALL'; // Initialize with 'ALL' selected by default

  // Example data for chat list
  List<Map<String, dynamic>> chatData = [
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'title': 'Chat 1',
      'subtitle': 'Chat 1 Description',
      'category': 'Category 1',
      'lastChatTime': DateTime(2023, 3, 27, 12, 30),
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'title': 'Chat 2',
      'subtitle': 'Chat 2 Description',
      'category': 'Category 1',
      'lastChatTime': DateTime(2023, 3, 26, 18, 45),
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'title': 'Chat 3',
      'subtitle': 'Chat 3 Description',
      'category': 'Category 2',
      'lastChatTime': DateTime(2023, 3, 25, 9, 10),
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'title': 'Chat 4',
      'subtitle': 'Chat 4 Description',
      'category': 'Category 2',
      'lastChatTime': DateTime(2023, 3, 24, 22, 35),
    },
    // Add more chats as needed
  ];

  @override
  Widget build(BuildContext context) {
    // Filter the chat list based on the selected category
    List<Map<String, dynamic>> filteredChatData = chatData.where((chat) {
      if (selectedCategory == 'ALL') {
        return true;
      }
      return chat['category'] == selectedCategory;
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
                      ChatCatergoryChipWidget(
                        categoryName: 'Category 1',
                        isSelected: selectedCategory == 'Category 1',
                        onSelected: (bool selected) {
                          setState(() {
                            selectedCategory = selected ? 'Category 1' : 'ALL';
                          });
                        },
                      ),
                      ChatCatergoryChipWidget(
                        categoryName: 'Category 2',
                        isSelected: selectedCategory == 'Category 2',
                        onSelected: (bool selected) {
                          setState(() {
                            selectedCategory = selected ? 'Category 2' : 'ALL';
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
                  imageUrl: filteredChatData[index]['imageUrl'],
                  title: filteredChatData[index]['title'],
                  message: filteredChatData[index]
                      ['subtitle'], // Changed from 'message' to 'subtitle'
                  lastChatTime: filteredChatData[index]['lastChatTime'],
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
                // Add functionality for the FloatingActionButton
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
