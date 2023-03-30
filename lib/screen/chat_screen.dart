import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocket_gpt/models/message_model.dart';
import 'package:pocket_gpt/services/chat_service.dart';
import 'package:pocket_gpt/widget/chat_message_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatScreen extends StatefulWidget {
  final int id;
  final String imageUrl;
  final String title;

  const ChatScreen(
      {required this.id, required this.imageUrl, required this.title, Key? key})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();

  final TextEditingController _messageController = TextEditingController();

  int _offset = 0;
  final int _limit = 20;
  bool _reachedEnd = false;
  late final List<Message> _messages = [];
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();

    _itemPositionsListener.itemPositions.addListener(_scrollListener);
    _fetchMoreMessages();
  }

  @override
  void dispose() {
    _itemPositionsListener.itemPositions.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final minIndex = _itemPositionsListener.itemPositions.value
        .where((position) => position.itemLeadingEdge < 0.1)
        .reduce((a, b) => a.index < b.index ? a : b)
        .index;
    if (minIndex == 0) {
      _fetchMoreMessages();
    }
  }

  Future<void> _fetchMoreMessages() async {
    if (!_reachedEnd) {
      List<Message> moreMessages =
          await _chatService.getChatMessages(widget.id, _offset, _limit);

      if (moreMessages.isEmpty) {
        setState(() {
          _reachedEnd = true;
        });
      } else {
        setState(() {
          _offset += moreMessages.length;
          _messages.insertAll(0, moreMessages);
        });
      }
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      Message newMessage = Message(
          chatId: widget.id,
          data: _messageController.text,
          chatTime: DateTime.now(),
          isSentByUser: 1);

      await _chatService.addChatMessage(newMessage);

      setState(() {
        _messages.insert(0, newMessage);
      });

      _itemScrollController.scrollTo(
          index: 0, duration: const Duration(milliseconds: 300));

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Row(
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 8.0),
          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            const SizedBox(
                width: 8), // Adjust spacing between the image and the title
            Text(
              widget.title,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          CupertinoButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.ellipsis, color: Colors.black),
          )
        ],
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
                child: ScrollablePositionedList.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = _messages[index];
                return ChatMessageWidget(message: message);
              },
              itemScrollController: _itemScrollController,
              itemPositionsListener: _itemPositionsListener,
              reverse: true,
            )),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              height: 120.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CupertinoTextField(
                      controller: _messageController,
                      placeholder: 'Send a message...',
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: CupertinoColors.lightBackgroundGray,
                          width: 1.0,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (value) => _sendMessage(),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _sendMessage,
                    child: const Icon(
                      CupertinoIcons.paperplane_fill,
                      size: 25.0,
                      color: CupertinoColors.activeBlue,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
