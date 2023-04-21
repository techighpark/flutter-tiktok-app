import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  // main.dart > Firebase.initilaizeApp하는 시점에
  // FirebaseAuth.instance를 만들면 된다.
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;
}

final authRepo = Provider((ref) => AuthenticationRepository());
