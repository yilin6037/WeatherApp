import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuth get _auth => _firebaseAuth;

  Future signIn({required String email, required String password}) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;

      if (user == null) {
        return;
      } else {
        return user;
      }
    } on FirebaseAuthException catch (e) {
      String message = e.code;

      if (e.code == 'wrong-password') {
        message = 'Incorrect email or password. Please try again.';
      } else if (e.code == 'user-not-found') {
        message = 'Incorrect email or password. Please try again.';
      } else if (e.code == 'user-disabled') {
        message = 'This account is disabled.';
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        message = 'Incorrect email or password. Please try again.';
      }

      Get.replace(message, tag: 'message');
    }
  }

  Future<String> register(
      {required String email, required String password}) async {
    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      if (user != null) {
        return user.uid;
      }
    } on FirebaseAuthException catch (e) {
      String message = e.code;

      switch (e.code) {
        case 'email-already-in-use':
          message =
              'The email is already in use. Please check your email address or log in if you already have an account';
          break;
        case 'invalid-email':
          message = 'The email is invalid. Please check you email address.';
          break;
        case 'operation-not-allowed':
          message = 'There is an error occured during registering.';
          break;
        case 'weak-password':
          message =
              'The password is too weak. Please try again with a stronger password.';
          break;
      }
      Get.replace(message, tag: 'message');
    }

    return '';
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      return FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
