// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:pocket_gpt/helpers/database_helper.dart';
import 'package:pocket_gpt/models/chat_model.dart';
import 'package:pocket_gpt/models/message_model.dart';

class ChatService {
  String CHAT_TB = 'chats';
  String MESSAGE_TB = 'messages';

  final DatabaseHelper _db = DatabaseHelper.instance;

  // Add chat
  Future<int> addChat(Chat chat) async {
    return await _db.insert(CHAT_TB, chat.toJson());
  }

  // Get chats with last message
  Future<List<Chat>> getChats() async {
    final db = await _db.database;
    final chats = await db.rawQuery('''
      SELECT c.*, m.id AS messageId, m.data, m.chatTime, m.chatId, m.isSentByUser
      FROM chats c
      LEFT JOIN messages m ON m.chatId = c.id AND m.id = (
        SELECT id FROM messages WHERE chatId = c.id ORDER BY id DESC LIMIT 1
      )
      ORDER BY CASE
          WHEN m.chatTime IS NOT NULL THEN m.chatTime
          ELSE c.createTime
      END DESC
    ''');

    final List<Chat> result = [];
    for (final chatMap in chats) {
      final chat = Chat.fromJson(chatMap);
      if (chatMap['messageId'] != null) {
        chat.lastMessage = Message(
            id: chatMap['messageId'] as int,
            chatId: chatMap['chatId'] as int,
            data: chatMap['data'] as String,
            chatTime: chatMap['chatTime'] != null
                ? DateTime.parse(chatMap['chatTime'] as String)
                : null,
            isSentByUser: chatMap['isSentByUser'] as int);
      }
      result.add(chat);
    }

    return result;
  }

  // Get unique cateogry
  Future<List<String>> getCategories() async {
    final db = await _db.database;
    final result = await db.rawQuery('SELECT DISTINCT category FROM chats');
    return result.map((e) => e['category'] as String).toList();
  }

  // Update chat
  Future<int> updateChat(Chat chat) async {
    return await _db.update(CHAT_TB, chat.toJson());
  }

  // Delete chat
  Future<int> deleteChat(int id) async {
    return await _db.delete(CHAT_TB, id);
  }

  // Get chat messages
  Future<List<Message>> getChatMessages(int chatId) async {
    final messageMaps = await _db.query(MESSAGE_TB,
        whereConditions: ['chatId = ?'],
        whereArgsLists: [
          [chatId],
        ],
        orderby: 'id desc');
    return messageMaps
        .map((messageMap) => Message.fromJson(messageMap))
        .toList();
  }

  // Add chat message
  Future<int> addChatMessage(Message message) async {
    return await _db.insert(MESSAGE_TB, message.toJson());
  }
}
