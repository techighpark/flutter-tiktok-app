import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/utils.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  /// Sign up using  email and password of [signUpFormProvider]
  Future<void> signUp(BuildContext context) async {
    print('signup_vm - signUp');
    state = const AsyncValue.loading();

    ///```dart
    /// final form = ref.read(signUpFormProvider);
    /// print(form); //{email: abc@123.co, password: abcd1234}
    /// ```
    final formNotifier = ref
        .read(signUpFormProvider.notifier)
        .state; //{email: abc@123.co, password: abcd1234}
    print(formNotifier);
    final usersVM = ref.read(usersProvider.notifier);

    ///guard is Transforms a Future that may fail into something that is safe to read.
    state = await AsyncValue.guard(() async {
      ///1. firebase > authentication
      final userCredential = await _authRepo.emailSignUp(
        formNotifier["email"],
        formNotifier["password"],
      );

      ///2. firebase > database
      await usersVM.createProfile(userCredential);
    });
    if (state.hasError && context.mounted) {
      ///custom widget
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.goNamed(InterestsScreen.routeName);
    }
  }
}

///A provider that exposes a value that can be modified from outside.
final signUpFormProvider = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () {
    print('signup_vm - signUpProvider');
    return SignUpViewModel();
  },
);
