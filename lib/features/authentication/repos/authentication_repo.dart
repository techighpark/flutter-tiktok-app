import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  /// main.dart > Firebase.initilaizeApp 하는 시점에
  /// FirebaseAuth.instance를 만들면 된다.
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => user != null;

  User? get user => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() {
    /*print(_firebaseAuth.authStateChanges());*/
    return _firebaseAuth.authStateChanges();
  }

  Future<UserCredential> emailSignUp(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Sign in using [email] and [password]
  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> githubSignIn() async {
    await _firebaseAuth.signInWithProvider(GithubAuthProvider());
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());

final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  /*print(repo);*/
  return repo.authStateChanges();
});
