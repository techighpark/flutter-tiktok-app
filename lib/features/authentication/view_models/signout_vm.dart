import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/utils.dart';

class SignOutViewModel extends AsyncNotifier {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signOut(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepo.signOut();
    });
    if (state.hasError && context.mounted) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go('/');
    }
  }
}

final signOutProvider = AsyncNotifierProvider<SignOutViewModel, void>(
  () => SignOutViewModel(),
);
