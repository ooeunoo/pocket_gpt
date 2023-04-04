import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocket_gpt/models/chat_model.dart';
import 'package:pocket_gpt/models/message_model.dart';
import 'package:pocket_gpt/services/chat_service.dart';
import 'package:pocket_gpt/services/openai_service.dart';
import 'package:pocket_gpt/widget/chat_loading_widget.dart';
import 'package:pocket_gpt/widget/chat_message_widget.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({required this.chat, Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _uuid = const Uuid();

  final ChatService _chatService = ChatService();
  final OpenAIService _openAIService = OpenAIService();

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  List<Message> _messages = [];
  bool waitingForAnswer = false;

  @override
  void initState() {
    super.initState();
    _loadChatMessages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 초기 채팅 메시지 로드
  Future<void> _loadChatMessages() async {
    List<Message> messages =
        await _chatService.getChatMessages(widget.chat.id as int);

    setState(() {
      _messages = messages;
    });
  }

  // 메시지 송신
  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      Message newMessage = Message(
          chatId: widget.chat.id as int,
          data: _messageController.text,
          chatTime: DateTime.now(),
          isSentByUser: 1,
          like: 0);

      int messageId = await _chatService.addChatMessage(newMessage);

      if (messageId > 0) {
        _messageController.clear();
        newMessage.id = messageId;
        setState(() {
          _messages.insert(0, newMessage);
        });

        _scrollToBottom();
        _receiveMessage(newMessage.data);
      }
    }
  }

  // 메시지 수신
  Future<void> _receiveMessage(String prompt) async {
    waitingForAnswer = true;

    String answer = await _openAIService.askToChatGPT(_messages, prompt);

    Message newMessage = Message(
        chatId: widget.chat.id as int,
        data: answer,
        chatTime: DateTime.now(),
        isSentByUser: 0,
        like: 0);

    int messageId = await _chatService.addChatMessage(newMessage);
    waitingForAnswer = false;

    if (messageId > 0) {
      if (mounted) {
        _messageController.clear();
        newMessage.id = messageId;
        setState(() {
          _messages.insert(0, newMessage);
        });
        _scrollToBottom();
      }
    }
  }

  Future<void> _toogleChatMessageLike(int index, Message message) async {
    message.like = message.like == 0 ? 1 : 0;
    int messageId = await _chatService.updateChatMessage(message);

    if (messageId > 0) {
      if (mounted) {
        setState(() {
          _messages[index] = message;
        });
      }
    }
  }

  // 화면 하단으로 스크롤
  void _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Row(
            children: [
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              const SizedBox(width: 8.0),
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.chat.imageUrl),
              ),
              const SizedBox(
                  width: 8), // Adjust spacing between the image and the title
              Text(
                widget.chat.title,
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
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 0 &&
                details.globalPosition.dx > screenWidth / 2) {
              Navigator.of(context).pop();
            }
          },
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return ChatMessageWidget(
                        key: ValueKey(_uuid.v4()),
                        message: message,
                        toogleLike: () async {
                          await _toogleChatMessageLike(index, message);
                        });
                  },
                  controller: _scrollController,
                ),
              ),
              if (waitingForAnswer) const ChatLoadingWidget(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
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
        ));
  }
}
