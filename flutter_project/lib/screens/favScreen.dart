import 'package:flutter/material.dart';
import 'package:global_solution_challenge_21/screens/CreateScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final favList = <Entry>{};

class FavScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget _builtList(){
        return ListView.builder(itemBuilder: (context, i){
          if(i.isOdd)
            return Divider();

          final index = i~/2; //TODO check for end of list
          if(index>= favList.length || favList.length ==0)
            return null;

          return _builtRow(favList.elementAt(index));
        },
            itemCount: favList.length * 2
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
              child: Text(
                alreadyFav ? "Remove From Favorites" : "Add To Favorites",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
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
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: _builtList(),
    );
  }
}
