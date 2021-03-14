import 'package:flutter/material.dart';
import 'package:global_solution_challenge_21/models/user.dart';
import 'package:global_solution_challenge_21/screens/Wrapper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:global_solution_challenge_21/services/auth.dart';
import 'screens/CreateScreen.dart';

void main() {
  runApp(MyAuthApp());
}

class MyAuthApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamProvider<CustomUser>.value(
        value: AuthService().onAuthStateChanged,
        initialData: null,
        child:  Wrapper(),
      ),
      onGenerateRoute: (settings) { //set page transitions settings. Can be used with Navigator.pushNamed(context, 'name');
        switch (settings.name) {
          case 'CreatePage':
            return PageTransition(child: CreatePage(), type: PageTransitionType.rightToLeft, settings: settings,);
            break;
          default:
            return null;
        }
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      title: 'ScienceCollab'
    );
  }
}