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
}

final videoRepo = Provider((ref) => VideosRepository());
