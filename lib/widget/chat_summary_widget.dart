import 'package:flutter/material.dart';
import 'package:pocket_gpt/screen/chat_screen.dart';

class ChatSummaryWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String message;
  final DateTime lastChatTime;

  const ChatSummaryWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.message,
    required this.lastChatTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(
              imageUrl: imageUrl,
              title: title,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
        );
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title),
        subtitle: Text(message),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${lastChatTime.hour}:${lastChatTime.minute}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
