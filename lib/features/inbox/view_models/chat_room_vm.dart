import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';
import 'package:tiktok_clone/features/inbox/repos/chat_room_repo.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class ChatRoomViewModel extends AsyncNotifier<List<ChatRoomModel>> {
  late final ChatRoomRepository _chatRoomRepository;
  List<ChatRoomModel> _list = [];

  Future<List<ChatRoomModel>> _fetchChatRooms() async {
    print('chat_room_vm - _fetchChatRooms');
    final result = await _chatRoomRepository.fetchChatRooms();
    print(result);
    final chatRooms = result.docs.map(
      (chat) => ChatRoomModel.fromJson(
        json: chat.data(),
        chatRoomId: chat.id,
      ),
    );
    return chatRooms.toList();
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

  @override
  FutureOr<List<ChatRoomModel>> build() async {
    print('chat_room_vm - build');
    _chatRoomRepository = ref.read(chatRoomRepo);
    _list = await _fetchChatRooms();
    print(_list);
    return _list;
  }
}

final chatRoomProvider =
    AsyncNotifierProvider<ChatRoomViewModel, List<ChatRoomModel>>(
        () => ChatRoomViewModel());
