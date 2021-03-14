import 'package:flutter/material.dart';
import 'package:global_solution_challenge_21/screens/favScreen.dart';
import 'package:global_solution_challenge_21/services/auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../CreateScreen.dart';

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

  //final newFavList = <Entry>{}; //need for changing icon
  //final newDelFavList = <Entry>{};

  final AuthService _authService = AuthService();

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
      for(Entry entry in UserInput.values){
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
    final alreadyFav = (favList.contains(entry));
    return ListTile(
      title: Text(
          entry.Identifier,
          style: _biggerFont),
      trailing: Icon(
        Icons.search,
        color: alreadyFav ? Colors.red : Colors.cyan,
      ),
      onTap: (){//when tapping the line
        //show description for item, use Emoticons
        Alert(
          context: context,
          type: AlertType.info,
          title: entry.Identifier,
          content: Column(
            children: <Widget>[
              Row(
                children: [
                  Icon(Icons.apartment),
                  Text(entry.Organisation,
                    style: _biggerFont,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.title),
                  Text(entry.Comment,
                    style: _biggerFont,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.mail),
                  Text(entry.Contact,
                    style: _biggerFont,
                  ),
                ],
              ),

            ],
          ),
          buttons: [
            DialogButton(
              child: (alreadyFav) ? Text("Remove From Favorites", style: TextStyle(color: Colors.white, fontSize: 15))
              : Text("Add To Favorites", style: TextStyle(color: Colors.white, fontSize: 15)),
              onPressed: () {//handle favorites TODO change text of button immediately
                setState(() {//change newly added/deleted lists
                  if(favList.contains(entry)){
                    favList.remove(entry);
                    //newDelFavList.add(entry);
                  }
                  else{
                    favList.add(entry);
                    //newFavList.add(entry);
                  }
                });
                Navigator.pop(context);
              },
              width: 180,
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
            IconButton(icon: Icon(Icons.favorite_border), onPressed: (){
              Navigator.pushNamed(context, 'FavPage');
            }),
            IconButton(icon: Icon(Icons.logout), onPressed: () {
              _authService.signOut();
            })
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
