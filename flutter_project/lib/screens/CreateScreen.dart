import 'package:flutter/material.dart';

//globals
final UserInput = <String>{};

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  final myController = TextEditingController(); //controller for handling the textField

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  void _onSubmitButtonPressed(){ //when pressing button
    if(!UserInput.contains(myController.text))
      UserInput.add(myController.text); //add to controller

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the that user has entered by using the
          // TextEditingController.
          content: Text(myController.text), //access textfield with myController.text
        );
      },
    );
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
        child: TextField(
          decoration: new InputDecoration(
              hintText: "Type in here"
          ),
          controller: myController,
          onSubmitted: _onSubmitEnter,
        ),
      ),
      floatingActionButton: FloatingActionButton( //for android
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: _onSubmitButtonPressed,
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}