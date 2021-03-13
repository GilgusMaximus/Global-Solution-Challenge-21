import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_solution_challenge_21/models/user.dart';
import 'package:global_solution_challenge_21/screens/Authentication/authenticate.dart';
import 'package:global_solution_challenge_21/screens/Home/home.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either Home or Authentcation widget
    final user = Provider.of<CustomUser>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return MyHomePage();
    }
  }
}
