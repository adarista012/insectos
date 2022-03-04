import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool errorMessage = false;
  String message = '';

  void setErrorMessage(bool message) {
    errorMessage = message;
    notifyListeners();
  }

  Stream<User?> get authChanges => _firebaseAuth.authStateChanges();

  Future signOut() async => await _firebaseAuth.signOut();

  String? currentU() {
    return _firebaseAuth.currentUser!.email;
  }

  // Future verifyEmail() async {
  //   User? user = FirebaseAuth.instance.currentUser;

  //   if (user != null && !user.emailVerified) {
  //     await user.sendEmailVerification();
  //   }
  // }

  // bool isV() {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   return user!.emailVerified;
  // }

  Future signUp({required String email, password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      setErrorMessage(true);
      if (e.code == 'weak-password') {
        setErrorMessage(true);
        message = 'La contraseña es muy debíl.';
        print(message);
      } else if (e.code == 'email-already-in-use') {
        setErrorMessage(true);
        message = 'Ya existe una cuenta con ese email.';
        print(message);
      } else {
        setErrorMessage(true);
        message = e.toString();
        print(e.toString());
      }
    }

    notifyListeners();
  }

  Future signIn({required String email, password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setErrorMessage(true);
        message = 'No existe un usuario con ese email.';
        print(message);
      } else if (e.code == 'wrong-password') {
        setErrorMessage(true);
        message = 'Error de contraseña para ese email.';
        print(message);
      }
    }
    notifyListeners();
  }

  Future resetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
