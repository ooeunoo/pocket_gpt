import 'package:flutter/material.dart';
import 'package:pocket_gpt/models/message_model.dart';

class ChatMessageWidget extends StatefulWidget {
  final Message message;

  const ChatMessageWidget({super.key, required this.message});

  @override
  State<ChatMessageWidget> createState() => _ChatMessageWidget();
}

class _ChatMessageWidget extends State<ChatMessageWidget> {
  late Message message;

  @override
  void initState() {
    message = widget.message;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isSentByUser == 1
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color:
              message.isSentByUser == 1 ? Colors.blueAccent : Colors.grey[300],
        ),
        child: Text(
          message.data,
          style: TextStyle(
            color: message.isSentByUser == 1 ? Colors.white : Colors.black,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
