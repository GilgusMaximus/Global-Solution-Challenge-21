import 'package:flutter/material.dart';
import 'package:global_solution_challenge_21/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ElevatedButton(
          child: Text('Sign In Anonymously'),
          onPressed: () async {
            dynamic authResult = await _authService.signInAnonymous();
            if(authResult == null) {
              print('Error signing in anonymously');
            } else {
              print('Sign in successfully');
              print(authResult.toString());
            }
          },
        ),
      ),
    );
  }
}
