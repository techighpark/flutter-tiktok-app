import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';

/// TODO [FirebaseMessaging]
/// - provider
class NotificationProvider extends AsyncNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> updateToken(String token) async {
    print('NotificationProvider - updateToken');
    final user = ref.read(authRepo).user;
    _db.collection("users").doc(user!.uid).update({"token": token});
  }

  @override
  FutureOr build() async {
    print('NotificationProvider - build');
    final token = await _messaging.getToken();
    if (token == null) return;
    await updateToken(token);

    ///Fires when a new FCM token is generated.
    _messaging.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }
}

final notificationsProvider =
    AsyncNotifierProvider(() => NotificationProvider());
