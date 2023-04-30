import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_vm.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    /// just for loading test
    /// ```dart
    /// await Future.delayed(
    ///   const Duration(seconds: 10),
    /// );
    /// ```
    _usersRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _usersRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    print('users_vm -> createAccount');
    if (credential.user == null) {
      throw Exception('Account not created');
    }

    state = const AsyncValue.loading();
    final formNotifier = ref.read(signUpFormProvider.notifier).state;
    final profile = UserProfileModel(
      hasAvatar: false,
      bio: formNotifier['birthday'] ?? "undefined",
      link: "undefined",
      uid: credential.user!.uid,
      name: credential.user!.displayName ?? formNotifier['username'],
      email: credential.user!.email ?? formNotifier['email'],
    );
    state = AsyncValue.data(profile);

    ///firebase - firestore repo
    await _usersRepository.createProfile(profile);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(
      state.value!.copyWith(hasAvatar: true),
    );
    await _usersRepository.updateUser(
      state.value!.uid,
      {"hasAvatar": true},
    );
  }

  Future<void> onProfileUpdate() async {
    if (state.value == null) return;

    // state = AsyncValue.data(
    //   state.value!.copyWith(hasAvatar: true),
    // );
    // await _usersRepository.updateUser(
    //   state.value!.uid,
    //   {"hasAvatar": true},
    // );
  }
}

final usersProvider =
    AsyncNotifierProvider<UsersViewModel, UserProfileModel>(() {
  print('users_vm -> usersProvider');
  return UsersViewModel();
});
