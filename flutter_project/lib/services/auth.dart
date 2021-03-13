import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // _ bedeutet pivate Variable
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // sign in anonymously method
  Future signInAnonymous() async {
    try {
      // generiert einen anonymen user und returned den user
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      User user = userCredential.user;
      return user;
    } catch(error) {
      print(error.toString());
      return null;
    }
  }
  // sign in with e-mail and password

  // register with e-mail and password

  // sign out

}