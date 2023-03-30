import 'package:pocket_gpt/models/message_model.dart';

class Chat {
  int? id;
  String imageUrl;
  String title;
  String category;
  DateTime? createTime;
  Message? lastMessage;

  Chat({
    this.id,
    required this.imageUrl,
    required this.title,
    required this.category,
    this.createTime,
    this.lastMessage,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'title': title,
        'category': category,
      };

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json['id'],
        imageUrl: json['imageUrl'],
        title: json['title'],
        category: json['category'],
        createTime: DateTime.parse(json['createTime']),
        lastMessage: json['lastMessage'] != null
            ? Message.fromJson(json['lastMessage'])
            : null,
      );

  String? getLastChatTimeString() {
    if (lastMessage == null) {
      return null;
    } else {
      return lastMessage!.chatTime?.toIso8601String();
    }
  }
}
