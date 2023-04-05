// ignore_for_file: non_constant_identifier_names

class RoleChat {
  final String id;
  final String role;
  final String category;
  final String title;
  final String description;
  final String system_message;
  final List<String> example_questions;

  RoleChat({
    required this.id,
    required this.role,
    required this.category,
    required this.title,
    required this.description,
    required this.system_message,
    required this.example_questions,
  });

  factory RoleChat.fromMap(Map<String, dynamic> data, String id) {
    return RoleChat(
      id: id,
      role: data['role'],
      category: data['category'],
      title: data['title'],
      description: data['description'],
      system_message: data['system_message'],
      example_questions: List<String>.from(data['example_questions']),
    );
  }
}
