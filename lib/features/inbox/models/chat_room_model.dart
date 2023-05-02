import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class ChatRoomModel {
  final String id;
  final List<UserProfileModel> users;

  ChatRoomModel({
    required this.id,
    required this.users,
  });

  ChatRoomModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        users = json['users'];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "users": users,
    };
  }
}
