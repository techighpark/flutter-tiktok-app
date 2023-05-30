import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class ChatRoomModel {
  final String id;
  final List<Map<String, String>> usersId;

  ChatRoomModel({
    required this.id,
    required this.usersId,
  });

  ChatRoomModel.fromJson({
    required Map<String, dynamic> json,
    required String chatRoomId,
  })  : usersId = json['usersId'],
        id = chatRoomId;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "usersId": usersId,
    };
  }
}
