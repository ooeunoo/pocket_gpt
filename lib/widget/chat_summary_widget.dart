import 'package:flutter/material.dart';
import 'package:pocket_gpt/models/chat_model.dart';

class ChatSummaryWidget extends StatefulWidget {
  final Chat chat;
  final Function(BuildContext context, Chat chat) goToChatScreen;
  final Function(Chat chat) deleteChat;

  const ChatSummaryWidget({
    Key? key,
    required this.chat,
    required this.goToChatScreen,
    required this.deleteChat,
  }) : super(key: key);

  @override
  State<ChatSummaryWidget> createState() => _ChatSummaryWidgetState();
}

class _ChatSummaryWidgetState extends State<ChatSummaryWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 채팅 삭제
  Future<void> _handleDeleteChat() async {
    setState(() {
      _isDeleting = true;
    });
    await widget.deleteChat(widget.chat);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Delete Chat"),
            content: const Text("Are you sure you want to delete this chat?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  _handleDeleteChat();
                  Navigator.pop(context, true);
                },
                child: const Text("Delete"),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        setState(() {
          _isDeleting = true;
        });
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onResize: () {
        if (!_isDeleting) {
          _controller.forward(from: 0);
        }
      },
      dismissThresholds: const {
        DismissDirection.endToStart: 0.2,
      },
      movementDuration: const Duration(milliseconds: 200),
      child: InkWell(
        onTap: () {
          widget.goToChatScreen(context, widget.chat);
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.chat.imageUrl),
          ),
          title: Text(widget.chat.title),
          subtitle: Text(
            widget.chat.lastMessage?.data ?? "",
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget.chat.lastMessage?.chatTime != null)
                Text(
                  '${widget.chat.lastMessage?.chatTime?.hour}:${widget.chat.lastMessage?.chatTime?.minute}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
