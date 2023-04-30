import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/utils.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

// create profile
  Future<void> createProfile(UserProfileModel profile) async {
    print('user_repo - createProfile');
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

// find profile
  Future<Map<String, dynamic>?> findProfile(String uid) async {
    print('user_repo - findProfile');
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

// update avatar
  Future<void> uploadAvatar(File file, String fileName) async {
    print('user_repo - uploadAvatar');
    final fileRef = _storage.ref().child('avatars/$fileName');
    await fileRef.putFile(file);
  }

// update avatar
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }
}

final userRepo = Provider((ref) => UserRepository());
