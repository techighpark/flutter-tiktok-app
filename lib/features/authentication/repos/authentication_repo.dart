import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/utils.dart';

class AuthenticationRepository {
  /// main.dart > Firebase.initilaizeApp 하는 시점에
  /// FirebaseAuth.instance를 만들면 된다.
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Current user from firebaseAuth
  User? get user => _firebaseAuth.currentUser;

  /// Check user is logged in.
  bool get isLoggedIn => user != null;

  /// Notifies about changes to the user's sign-in state (such as sign-in or sign-out).
  Stream<User?> authStateChanges() {
    /*print(_firebaseAuth.authStateChanges());*/
    return _firebaseAuth.authStateChanges();
  }

  /// Sign up using [email] and [password]
  Future<UserCredential> emailSignUp(
    String email,
    String password,
  ) {
    print('auth_repo -> emailSignUp');
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Sign in using [email] and [password]
  Future<void> signIn(String email, String password) async {
    print('auth_repo -> signIn');
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> githubSignIn() async {
    await _firebaseAuth.signInWithProvider(
      GithubAuthProvider(),
    );
  }
}

final authRepo = Provider((ref) {
  print('auth_repo -> authRepo');
  return AuthenticationRepository();
});

final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
