import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videoRepo);
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    print("uploaded_video_vm - uploadVideo");
    final user = ref.read(authRepo).user;

    /// Instance of [UserProfileModel]
    final userProfile = ref.read(usersProvider).value;

    /// Instance of [UsersViewModel]
    /// final userProfileNotifier = ref.read(usersProvider.notifier);

    /// AsyncData<UserProfileModel>(value: Instance of [UserProfileModel])
    /// final userProfileNotifierState = ref.read(usersProvider.notifier).state;

    /// Instance of 'Future<Map<String, dynamic>?>'
    /// final userRepoFindProfile = ref.read(userRepo).findProfile(user!.uid);

    if (userProfile != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(
        () async {
          final task = await _repository.uploadVideoFile(video, user!.uid);

          ///When my task is completed, metadata has data.
          if (task.metadata != null) {
            final uploadedVideo = VideoModel(
              creator: userProfile.name,
              title: "From Flutter",
              description: "Here we go!",
              fileUrl: await task.ref.getDownloadURL(),
              thumbnailUrl: "",
              likes: 0,
              comments: 0,
              creatorUid: user.uid,
              createdAt: DateTime.now().millisecondsSinceEpoch,
            );
            await _repository.saveVideo(uploadedVideo);

            context.pop();
            context.pop();

            /// context.pushReplacement("/home");
          }
        },
      );
    }
  }
}

final uploadVideoProvider =
    AsyncNotifierProvider<UploadVideoViewModel, void>(() {
  return UploadVideoViewModel();
});
