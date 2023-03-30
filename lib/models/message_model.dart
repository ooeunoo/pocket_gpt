class Message {
  int? id;
  int chatId;
  String data;
  DateTime? chatTime;
  int isSentByUser;

  Message({
    this.id,
    required this.chatId,
    required this.data,
    required this.chatTime,
    required this.isSentByUser,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'chatId': chatId,
        'data': data,
        'chatTime': chatTime?.toIso8601String(),
        'isSentByUser': isSentByUser,
      };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json['id'],
        chatId: json['chatId'],
        data: json['data'],
        chatTime: DateTime.parse(json['chatTime']),
        isSentByUser: json['isSentByUser'],
      );
}
