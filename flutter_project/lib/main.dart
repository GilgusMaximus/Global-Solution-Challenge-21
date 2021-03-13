import 'package:flutter/material.dart';
import 'package:global_solution_challenge_21/screens/Wrapper.dart';
import 'package:page_transition/page_transition.dart';

import 'screens/CreateScreen.dart';

void main() {
  //runApp(MyApp());
  runApp(Wrapper());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScienceCollab', //TODO better title for app
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) { //set page transitions settings. Can be used with Navigator.pushNamed(context, 'name');
        switch (settings.name) {
          case 'CreatePage':
            return PageTransition(child: CreatePage(), type: PageTransitionType.rightToLeft);
            break;
          default:
            return null;
        }
      },
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  void _pushCreate(){ //create a new entry
    Navigator.pushNamed(context, 'CreatePage');
  }

  void _pushSearch(){ //TODO participate -> show in main home screen

  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar( //navigation window
          title: Text(widget.title),
          actions: [
            IconButton(icon: Icon(Icons.add), onPressed: _pushCreate), //better visuals with Containers, Add Dividers
            IconButton(icon: Icon(Icons.search), onPressed: _pushSearch)
          ], //TODO transitions to other views!
        ),
        body: Center(
           child: Text("This is a test", style: _biggerFont,)
        ), //TODO better body construction
      );
  }
}


