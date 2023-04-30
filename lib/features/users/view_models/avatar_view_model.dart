import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/widgets/avatar.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _userRepository;
  late final UsersViewModel _usersViewModel;

  @override
  FutureOr<void> build() {
    _userRepository = ref.read(userRepo);
    _usersViewModel = ref.read(usersProvider.notifier);
  }

  Future<void> uploadAvatar(File file) async {
    print('avatar_vm - uploadAvatar');
    state = const AsyncValue.loading();
    final fileName = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(() async {
      /// upload to firebase storage
      await _userRepository.uploadAvatar(
        file,
        fileName,
      );

      /// update firebase
      _usersViewModel.onAvatarUpload();
    });
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(() {
  print('avatar_vm - avatarProvider');
  return AvatarViewModel();
});
