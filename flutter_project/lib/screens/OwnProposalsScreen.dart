import 'package:flutter/material.dart';
import 'package:global_solution_challenge_21/screens/CreateScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final OwnEntries = <Entry>{}; //TODO get all own proposals

class OwnEntryScreen extends StatefulWidget {
  @override
  _OwnEntryScreenState createState() => _OwnEntryScreenState();
}

class _OwnEntryScreenState extends State<OwnEntryScreen> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();

    OwnEntries.addAll(UserInput.values); //TODO firebase: grab all own entries
  }

  Widget _builtList(){
    return ListView.builder(itemBuilder: (context, i){
      if(i.isOdd)
        return Divider();

      final index = i~/2; //TODO check for end of list
      if(index>= OwnEntries.length || OwnEntries.length ==0)
        return null;

      return _builtRow(OwnEntries.elementAt(index));
    },
        itemCount: OwnEntries.length * 2
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
      onTap: () => openChangeMenu(entry)
    );
  }


  void openChangeMenu(Entry entry){  //TODO show menu for changing own entries
    Navigator.of(context).push(
      MaterialPageRoute<void>(

        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Update Data'),
            ),
            body:  Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: entry.Identifier,
                      onFieldSubmitted: (String value){ //Update values
                        entry.Identifier = value; //TODO update this for firebase
                        UserInput[entry.hash] = entry;
                      },
                    ),
                    TextFormField(
                      initialValue: entry.Organisation,
                      onFieldSubmitted: (String value){
                        entry.Organisation = value; //TODO update this for firebase
                        UserInput[entry.hash] = entry;
                      },
                    ),
                    TextFormField(
                      initialValue: entry.Comment,
                      onFieldSubmitted: (String value){
                        entry.Comment = value; //TODO update this for firebase
                        UserInput[entry.hash] = entry;
                      },
                    ),
                    TextFormField(
                      initialValue: entry.Contact,
                      onFieldSubmitted: (String value){
                        entry.Contact = value; //TODO update this for firebase
                        UserInput[entry.hash] = entry;
                      },
                    )
                  ],

                ),
              ),
            ),
          );
        }, // ...to here.
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Own Proposals"),
      ),
      body: _builtList(),
    );
  }
}
