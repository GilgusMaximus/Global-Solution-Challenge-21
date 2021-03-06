import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:global_solution_challenge_21/models/user.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference orgaCollection = FirebaseFirestore.instance.collection('organisations');
  final CollectionReference projectCollection = FirebaseFirestore.instance.collection('projects');


  Future createOrganization(String orgaName, String country, List<String> fields, bool isUni) {
    return orgaCollection.add({
      'name': orgaName,
      'country': country,
      'field': fields,
      'isUni': isUni,
      'uId': uid,
    });
  }

  Future updateOrganisationData(String docId, CustomUser user) {
    return orgaCollection.doc(docId).update(user.getFieldsAsMaps());
  }

  Future createProjectOffer(String orgaName, String field, String description, String contact, String title) {
    return projectCollection.add({
      'name': orgaName,
      'field': field,
      'userid': uid,
      'title': title,
      'description': description,
      'contact': contact,
    });
  }

  Future updateProjectOffer(String docId, Map<String, dynamic> elements) {
    return projectCollection.doc(docId).update(elements);
  }

  // Erlaubt es nach strings zu suchen die gleich sind oder mit dem Searchteil starten
  Future searchForOrgaString(String searchString, String dataField) {
    return orgaCollection.where(dataField, isGreaterThanOrEqualTo: searchString).get();
  }

  Future searchForProjectString(String searchString, String dataField) {
    print(dataField + " " + searchString);
    return projectCollection.where(dataField, isGreaterThanOrEqualTo: searchString).where(dataField, isLessThan: searchString + 'z').get();
  }
  
  Future getOrgaData() {
    return orgaCollection.where('uId', isEqualTo: uid).get();
  }
  
}