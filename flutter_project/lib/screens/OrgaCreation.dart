import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:global_solution_challenge_21/models/user.dart';
import 'package:global_solution_challenge_21/services/database.dart';


class OrgaCreate extends StatefulWidget {

  CustomUser _user ;

  @override
  _OrgaCreateState createState() => _OrgaCreateState();
}

class _OrgaCreateState extends State<OrgaCreate> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  //controller for handling the textField
  final OrgaNameController = TextEditingController();
  final CountryController = TextEditingController();
  final FieldController = TextEditingController();
  DatabaseService _database = null;
  bool isUniCheckbox = false;
  String orgaDataDocId = "";

  void _onSubmitButtonPressed(){ //when pressing button
    widget._user.updateName(OrgaNameController.text);
    widget._user.updateCountry(CountryController.text);
    print(FieldController.text);
    List<String> fields = FieldController.text.split(',');
    print(fields);
    widget._user.addFields(fields);
    widget._user.setIsUni(isUniCheckbox);

    if(orgaDataDocId != ""){
      _database.updateOrganisationData(orgaDataDocId, widget._user);
    } else {
      _database.createOrganization(widget._user.name, widget._user.country, widget._user.fields, widget._user.isUni);
    }
  }

  String buildCSeperatedString(List<String> fields){
    String string = "";
    fields.forEach((element) {string += element + ","; });
    return string.substring(0, string.length-1);
  }


   void setUpExistingData() async {
    if(widget._user.name == null) {
      dynamic result = await _database.getOrgaData();
      if (result != null && result.docs.length != 0) {
        print(result.docs.length);
        QueryDocumentSnapshot userData = result.docs[0];
        widget._user.country = userData["country"];
        widget._user.name = userData["name"];
        widget._user.fields = userData["field"].cast<String>();
        widget._user.setIsUni(userData["isUni"]);
        orgaDataDocId = userData.id;
      }
    }
    CountryController.text = (widget._user.country != "") ? widget._user.country : "";
    OrgaNameController.text = (widget._user.name != "") ? widget._user.name : "";
    FieldController.text = (widget._user.fields.length > 0) ? buildCSeperatedString(widget._user.fields) : "";
    setState(() {
      isUniCheckbox = widget._user.isUni;
    });

  }

  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => setUpExistingData());
  }

  void _onSubmitEnter(String string){ //when pressing enter
    _onSubmitButtonPressed();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    widget._user = args;
    _database = DatabaseService(uid: widget._user.uid);
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
                    hintText: "Name of your Organisation"
                ),
                controller: OrgaNameController,
                onSubmitted: _onSubmitEnter,
              ),
              TextField(
                decoration: new InputDecoration(
                    hintText: "The country of your organisation"
                ),
                controller: CountryController,
                onSubmitted: _onSubmitEnter,
              ),
              TextField(
                decoration: new InputDecoration(
                    hintText: "Fields your organisation operates in (Comma seperated)"
                ),
                controller: FieldController,
                onSubmitted: _onSubmitEnter,
              ),
              CheckboxListTile(
                title: Text("We are an University:"),
                value: isUniCheckbox,
                onChanged: (newValue) {
                  setState(() {
                    isUniCheckbox = newValue;
                  });
                },
              )
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