import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class VideoPostViewModel
    extends FamilyAsyncNotifier<Map<String, dynamic>, String> {
  late final VideosRepository _videoRepository;
  late final AuthenticationRepository _authenticationRepository;
  late final String _videoId;
  bool _isLiked = false;
  int _likeCount = 0;

  @override
  FutureOr<Map<String, dynamic>> build(String videoId) async {
    _videoRepository = ref.read(videoRepo);
    _authenticationRepository = ref.read(authRepo);
    _videoId = videoId;
    _isLiked = await _videoRepository.isLiked(
        videoId: videoId, userId: _authenticationRepository.user!.uid);
    _likeCount = await _videoRepository.likeCount(videoId: videoId);
    print("video_post_vm - build");
    return {"isLiked": _isLiked, 'likeCount': _likeCount};
  }

  FutureOr<void> toggleLikeVideo() async {
    final user = _authenticationRepository.user;
    await _videoRepository.toggleLikeVideo(_videoId, user!.uid);
    _isLiked = !_isLiked;
    if (_isLiked) {
      _likeCount += 1;
    } else {
      _likeCount -= 1;
    }
    state = AsyncValue.data({"isLiked": _isLiked, 'likeCount': _likeCount});
  }
}

final videoPostProvider = AsyncNotifierProvider.family<VideoPostViewModel,
    Map<String, dynamic>, String>(
  () => VideoPostViewModel(),
);
