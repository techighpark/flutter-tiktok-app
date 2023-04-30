import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/utils.dart';

class SocialAuthViewModel extends AsyncNotifier<void> {
  late AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> githubSignIn(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
          () async => await _repository.githubSignIn(),
    );
    if (context.mounted) {
      if (state.hasError) {
        showFirebaseErrorSnack(context, state.error);
      } else {
        context.go("/home");
      }
    }
  }
}

final socialAuthProvider = AsyncNotifierProvider<SocialAuthViewModel, void>(
      () => SocialAuthViewModel(),
);
