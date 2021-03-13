import 'package:flutter/material.dart';

//globals
final UserInput = <Entry>{};

class Entry{
  String Identifier;
  String Organisation;
  String Comment = "";
  String Contact = "";

  Entry(@required this.Identifier, @required this.Organisation, this.Comment, this.Contact);

}

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  final IDController = TextEditingController(); //controller for handling the textField
  final OrgaController = TextEditingController();
  final CommentController = TextEditingController();
  final ContactController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    IDController.dispose();
    super.dispose();
  }

  void _onSubmitButtonPressed(){ //when pressing button
    Entry entry = Entry(IDController.text, OrgaController.text, CommentController.text, ContactController.text);

    if(IDController.text != "" && OrgaController.text != ""){ //TODO generate Hash and check if our Obj is already in List
      UserInput.add(entry); //add to controller

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Item added!"), //access textfield with myController.text
          );
        },
      );

      //clearing text
      IDController.clear();
      OrgaController.clear();
      CommentController.clear();
      ContactController.clear();

    }

  }

  void _onSubmitEnter(String string){ //when pressing enter
    _onSubmitButtonPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //navigation window
        title: Text("Create a new Proposal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                decoration: new InputDecoration(
                    hintText: "Project Identifier"
                ),
                controller: IDController,
                onSubmitted: _onSubmitEnter,
              ),
              TextField(
                decoration: new InputDecoration(
                    hintText: "Organisation"
                ),
                controller: OrgaController,
                onSubmitted: _onSubmitEnter,
              ),
              TextField(
                decoration: new InputDecoration(
                    hintText: "Comment"
                ),
                controller: CommentController,
                onSubmitted: _onSubmitEnter,
              ),
              TextField(
                decoration: new InputDecoration(
                    hintText: "Contact Info"
                ),
                controller: ContactController,
                onSubmitted: _onSubmitEnter,
              ),
            ],

          ),
        ),
      ),
      floatingActionButton: FloatingActionButton( //for android
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: _onSubmitButtonPressed,
        tooltip: 'Create new Entry',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}