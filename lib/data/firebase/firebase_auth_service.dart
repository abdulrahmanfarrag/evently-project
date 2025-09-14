import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<void> createAccountWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
          await value.user?.updateDisplayName(name);
        });
  }

  static Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
