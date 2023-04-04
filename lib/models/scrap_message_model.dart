class Message {
  int? id;
  String title;
  String data;

  Message({
    this.id,
    required this.title,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'data': data,
      };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json['id'],
        title: json['title'],
        data: json['data'],
      );
}
