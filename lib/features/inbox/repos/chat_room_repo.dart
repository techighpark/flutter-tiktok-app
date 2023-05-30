import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class ChatRoomRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// fetch, pagination, infinite scroll
  Future<QuerySnapshot<Map<String, dynamic>>> fetchChatRooms() {
    print('chat_room_repo - fetchChatRooms');
    final query = _db.collection("chat_rooms");
    return query.get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUsers() async {
    List users = [];
    final querySnapshot = await _db.collection('users').get();
    return querySnapshot;
  }

  /// create profile
  Future<void> createChatroom(List<UserProfileModel> users) async {
    print('chat_room_repo - createChatroom');

    /// await _db.collection("chat_rooms").doc(profile.uid).set(profile.toJson());
  }
}

final chatRoomRepo = Provider((ref) => ChatRoomRepository());
