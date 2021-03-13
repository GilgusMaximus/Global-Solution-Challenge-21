import 'package:flutter/material.dart';
import 'package:global_solution_challenge_21/screens/Authentication/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            child: SignIn()
        )
    );
  }
}
