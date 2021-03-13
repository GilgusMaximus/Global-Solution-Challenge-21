import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  void _pushCreate() {
    //create a new entry
    Navigator.pushNamed(context, 'CreatePage');
  }

  void _pushSearch() {
    //TODO participate -> show in main home screen
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        //navigation window
        title: Text('Titles'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: _pushCreate),
          //better visuals with Containers, Add Dividers
          IconButton(icon: Icon(Icons.search), onPressed: _pushSearch)
        ], //TODO transitions to other views!
      ),
      body: Center(
          child: Text(
        "This is a test",
        style: _biggerFont,
      )), //TODO better body construction
    ));
  }
}
