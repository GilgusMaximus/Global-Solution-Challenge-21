import 'dart:html';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'screens/CreateScreen.dart';

void main() {
  runApp(MyApp());
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
  final myController = TextEditingController();

  final filteredList = <Entry>{}; //remove items from here where input != what we want

  @override
  void initState() {
    super.initState();

    myController.addListener(_onChangeSearch); //hook listener, when changing input
  }

  void _pushCreate(){ //create a new entry
    Navigator.pushNamed(context, 'CreatePage');
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  void _onChangeSearch(){ //TODO participate -> show in main home screen
    setState(() {
      filteredList.clear();
      for(Entry entry in UserInput){
        if(entry.Identifier.contains(myController.text))
          filteredList.add(entry);
      }
    });
  }

  Widget _builtList(){
    return Flexible(
        child: ListView.builder(itemBuilder: (context, i){
          if(i.isOdd)
            return Divider();

          final index = i~/2; //TODO check for end of list
          if(index>= filteredList.length || filteredList.length ==0)
            return null;

          return _builtRow(filteredList.elementAt(index));
        },
            itemCount: filteredList.length * 2
        )
    );
  }

  Widget _builtRow(Entry entry){
    return ListTile(
      title: Text(
          entry.Identifier,
          style: _biggerFont),
      trailing: Icon(
        Icons.search,
        color: Colors.cyan,
      ),
      onTap: (){//when tapping the line
        //show description for item
        Alert(
          context: context,
          type: AlertType.info,
          title: entry.Identifier,
          content: Column(
            children: <Widget>[
              Text(entry.Organisation,
            style: _biggerFont,
                ),

            ],
          ),
          buttons: [
            DialogButton(
              child: Text(
                "Got it!",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context), //TODO can also do fancy stuff here!
              width: 120,
            )
          ],
        ).show();

      },
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar( //navigation window
          title: Text(widget.title),
          actions: [
            IconButton(icon: Icon(Icons.add), onPressed: _pushCreate), //better visuals with Containers, Add Dividers
          ], //TODO transitions to other views!
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child :Column(
            children: [
              TextField(
                decoration: new InputDecoration(
                    hintText: "Search"
                ),
                controller: myController,
              ),
             _builtList()
            ],
          ),
        ),
      );
  }
}


