import 'package:flutter/material.dart';
import 'package:global_solution_challenge_21/models/user.dart';
import 'package:global_solution_challenge_21/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService = AuthService();
  // Asssociated to form
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = "";
  String password = "";

  String registerError = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        elevation: 0.0,
        title: Text('Register'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                // returns to widget of state
                widget.toggleView();
              },
              icon: Icon(Icons.person, color: Colors.black,),
              label: Text('Sign In    ',
              style: TextStyle(color: Colors.black),
              ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
          children: <Widget>[
            Text("ScienceCollab",
              style: TextStyle(fontSize: 40),),
            SizedBox(height: 20.0),
            // E-Mail
            TextFormField(
              // validator: null if an email was entered, otherwise helper text
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
                  dynamic user = await _authService.register(email, password);
                  if(user == null) {
                    setState(() => registerError = 'Registration failed. Please use a correct E-mail and password ');
                  } else {
                    print(user);
                  }
                }
              },
              child: Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.cyan[900],
                  onPrimary: Colors.white
              ),
            ),
            SizedBox(height: 12,),
            Text(
              registerError,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
