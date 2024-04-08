import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<bool> signUp(
      {required String email,
      required String password,
      required String name}) async {
    const String dummyProfilePicUrl =
        "https://static.vecteezy.com/system/resources/previews/007/226/475/original/user-account-circle-glyph-color-icon-user-profile-picture-userpic-silhouette-symbol-on-white-background-with-no-outline-negative-space-illustration-vector.jpg";
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser
          ?.updatePhotoURL(dummyProfilePicUrl);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      print("Called Signout on Service");
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
