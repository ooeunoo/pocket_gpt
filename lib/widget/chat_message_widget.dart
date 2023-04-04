import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_gpt/models/message_model.dart';

class ChatMessageWidget extends StatefulWidget {
  final Message message;
  final Future<void> Function() toogleLike;

  const ChatMessageWidget(
      {super.key, required this.message, required this.toogleLike});

  @override
  State<ChatMessageWidget> createState() => _ChatMessageWidget();
}

class _ChatMessageWidget extends State<ChatMessageWidget> {
  late Message message;
  late Future<void> Function() toogleLike;

  @override
  void initState() {
    message = widget.message;
    toogleLike = widget.toogleLike;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isSentByUser = message.isSentByUser == 1;
    return isSentByUser
        ? UserMessage(message: message)
        : GPTMessage(message: message, toogleLike: toogleLike);
  }
}

// 유저 메시지
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
        ],
      ),
    );
  }
}

// GPT 메시지
class GPTMessage extends StatelessWidget {
  final Message message;
  final Future<void> Function() toogleLike;

  const GPTMessage(
      {super.key, required this.message, required this.toogleLike});

  @override
  Widget build(BuildContext context) {
    final longPressGesture = LongPressGestureRecognizer()
      ..onLongPress = () {
        final ClipboardData data = ClipboardData(text: message.data);
        Clipboard.setData(data);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message copied to clipboard'),
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      };

    return GestureDetector(
        onLongPress: longPressGesture.onLongPress,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(width: 40),
              ],
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 50),
                  GestureDetector(
                    onTap: () {
                      toogleLike();
                    },
                    child: Icon(
                      message.like == 1
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: message.like == 1 ? Colors.red : null,
                    ),
                  )
                ])
          ]),
        ));
  }
}
