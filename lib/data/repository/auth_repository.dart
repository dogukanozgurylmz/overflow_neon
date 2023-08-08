import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  late final FirebaseAuth _auth;

  AuthRepository() {
    _auth = FirebaseAuth.instance;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
