import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';
import 'package:tiktok_clone/features/inbox/repos/chat_room_repo.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class ChatRoomViewModel extends AsyncNotifier<void> {
  late final ChatRoomRepository _chatRoomRepository;

  @override
  FutureOr<void> build() async {
    _chatRoomRepository = ref.read(chatRoomRepo);
  }

  Future<List<UserProfileModel>> getUsers() async {
    final result = await _chatRoomRepository.getUsers();
    final users = result.docs.map(
      (user) => UserProfileModel.fromJson(
        user.data(),
      ),
    );
    return users.toList();
  }
}

final chatRoomProvider =
    AsyncNotifierProvider<ChatRoomViewModel, void>(() => ChatRoomViewModel());
