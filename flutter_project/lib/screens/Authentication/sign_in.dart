import 'dart:html';

import 'package:flutter/material.dart';
import 'package:global_solution_challenge_21/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = "";
  String password = "";

  String signInError = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                // returns to widget of state
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            // E-Mail
            TextFormField(
              validator: (val) => val.isEmpty ? 'Please enter an Email' : null,
              // wenn etwas eingetragen wird in das Text Feld
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            SizedBox(height: 20.0),
            // Passwort
            TextFormField(
              validator: (val) => val.length < 6 ? 'Use at least 6 characters' : null,
              obscureText: true,
              // wenn etwas eingetragen wird in das Text Feld
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                // validates the input of our form fields
                // if a string is returned, it will place the text automatically on the view
                if(_formKey.currentState.validate()) {
                  dynamic user = await _authService.signInWithEmail(email, password);
                  if(user == null) {
                    setState(() => signInError = 'Sign in failed ');
                  } else {
                    print(user);
                  }
                }
              },
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white
              ),
            ),
            SizedBox(height: 12,),
            Text(
              signInError,
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
        ),
      ),
    );
  }
}
