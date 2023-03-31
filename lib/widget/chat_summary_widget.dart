import 'package:flutter/material.dart';
import 'package:pocket_gpt/models/chat_model.dart';

class ChatSummaryWidget extends StatelessWidget {
  final Chat chat;
  final Function(BuildContext context, Chat chat) goToChatScreen;

  const ChatSummaryWidget(
      {Key? key, required this.chat, required this.goToChatScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goToChatScreen(context, chat); // 함수를 호출합니다.
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(chat.imageUrl),
        ),
        title: Text(chat.title),
        subtitle: Text(
          chat.lastMessage?.data ?? "",
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (chat.lastMessage?.chatTime !=
                null) // lastChatTime이 null이 아닐 때만 출력합니다.
              Text(
                '${chat.lastMessage?.chatTime?.hour}:${chat.lastMessage?.chatTime?.minute}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
