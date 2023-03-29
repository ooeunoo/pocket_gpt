import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String imageUrl;
  final String title;

  const ChatScreen({required this.imageUrl, required this.title, Key? key})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Add functionality for the more_vert button
            },
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: ListView(
              children: const [
                // Add chat history widgets here
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Add functionality to send a message
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
