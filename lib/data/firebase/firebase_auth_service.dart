import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool isInitialize = false;


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

  static Future<void> _initSignIn() async {
    if (!isInitialize) {
      await _googleSignIn.initialize(
          serverClientId: '584017017251-b0ransu8lg97c2h0g7fa9sbogm0r74ju.apps.googleusercontent.com');
    }
    isInitialize = true;
  }
  static Future <UserCredential> signInWithGoogle() async {
     _initSignIn();

     GoogleSignInAccount account = await _googleSignIn.authenticate();
     final idToken = account.authentication.idToken;
     final authClient = account.authorizationClient;
    GoogleSignInClientAuthorization? auth = await authClient.authorizationForScopes(["email" ,"profile"]);
    final accessToken = auth?.accessToken;

    final Credential = GoogleAuthProvider.credential(idToken: idToken , accessToken: accessToken);
    return await FirebaseAuth.instance.signInWithCredential(Credential);
}


  static User? getUserData() {
    return firebaseAuth.currentUser;
  }
  }

