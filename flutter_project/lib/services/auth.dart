import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:global_solution_challenge_21/models/user.dart';


class AuthService {
  // _ bedeutet pivate Variable
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  CustomUser _firebaseUserToCustomUser(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // listen change user stream (loggt sich ein oder aus)
  Stream<CustomUser> get onAuthStateChanged => _firebaseAuth
      .authStateChanges()
      .map((User user) => _firebaseUserToCustomUser(user));

  // sign in anonymously method
  Future signInAnonymous() async {
    try {
      // generiert einen anonymen user und returned den user
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      User user = userCredential.user;
      return _firebaseUserToCustomUser(user);
    } catch(error) {
      print(error.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      // generiert einen anonymen user und returned den user
      return await _firebaseAuth.signOut();
    } catch(error) {
      print(error.toString());
      return null;
    }
  }

  // sign in with e-mail and password

  // register with e-mail and password

  // sign out

}