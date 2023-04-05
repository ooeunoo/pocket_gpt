import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocket_gpt/config/role_chat_category.dart';
import 'package:pocket_gpt/models/role_chat_model.dart';

class RoleChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 카테고리를 인자로 넘기면 해당 카테고리를 가진 데이터들이 반환되는 함수(getRoleChatByCategory())
  Future<List<RoleChat>> getRoleChatByCategory(
      RoleChatCategory category) async {
    String categoryString = _getCategoryString(category);

    QuerySnapshot querySnapshot = await _firestore
        .collection('role_chats')
        .where('category', isEqualTo: categoryString)
        .get();

    List<RoleChat> roleChats = [];
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      final data = doc.data();
      if (data != null) {
        RoleChat roleChat =
            RoleChat.fromMap(data as Map<String, dynamic>, doc.id);
        roleChats.add(roleChat);
      }
    }

    return roleChats;
  }

  String _getCategoryString(RoleChatCategory category) {
    return category.toString().split('.').last;
  }
}
