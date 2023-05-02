import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  ///Storage -> upload a video file.
  UploadTask uploadVideoFile(File video, String uid) {
    print("videos_repo - uploadVideoFile");
    final fileRef = _storage.ref().child(
        '/videos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}');
    return fileRef.putFile(video);
  }

  ///Firestore -> save a video document.
  Future<void> saveVideo(VideoModel data) async {
    print("videos_repo - saveVideo");
    await _db.collection('videos').add(data.toJson());
  }

  /// fetch, pagination, infinite scroll
  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos({
    int? lastItemCreatedAt,
  }) {
    final query = _db
        .collection("videos")
        .orderBy("createdAt", descending: true)
        .limit(2);

    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }

  Future<void> toggleLikeVideo(String videoId, String userId) async {
    print("videos_repo - toggleLikeVideo");

    /// expensive query to find whether I liked or not
    /// await _db.collection('likes').where("videoId", isEqualTo: videoId).where("userId",isEqualTo: userId);
    final query = _db.collection('likes').doc("${videoId}000$userId");
    final like = await query.get();
    if (!like.exists) {
      await query.set({
        "createdAt": DateTime.now().millisecondsSinceEpoch,
      });
    } else {
      await query.delete();
    }
  }

  Future<bool> isLiked({
    required String videoId,
    required String userId,
  }) async {
    final query = _db.collection('likes').doc("${videoId}000$userId");
    final like = await query.get();
    print("videos_repo - isLiked : ${like.exists}");
    return like.exists;
  }

  Future likeCount({
    required String videoId,
  }) async {
    final query = _db.collection('videos').doc("$videoId");
    final videoRef = await query.get();
    final video = videoRef.data();
    print("videos_repo - likeCount");
    if (video == null) {
      return 0;
    } else {
      return video['likes'];
    }
  }
}

final videoRepo = Provider((ref) => VideosRepository());
