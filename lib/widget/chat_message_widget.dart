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
    final isSentByUser = message.isSentByUser == 1;
    return isSentByUser
        ? UserMessage(message: message)
        : GPTMessage(message: message);
  }
}

class UserMessage extends StatelessWidget {
  final Message message;

  const UserMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 40),
          const Padding(
            padding: EdgeInsets.only(
              right: 1.0,
            ),
            child: Text(
              '3:45 PM', // Replace with actual chat time
              style: TextStyle(
                color: Colors.black54,
                fontSize: 10.0,
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.yellow[200],
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    message.data,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/avatar2.png'),
            ),
          )
        ],
      ),
    );
  }
}

class GPTMessage extends StatelessWidget {
  final Message message;

  const GPTMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey[300],
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    message.data,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 1.0),
            child: Text(
              '3:45 PM', // Replace with actual chat time
              style: TextStyle(
                color: Colors.black54,
                fontSize: 10.0,
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}
