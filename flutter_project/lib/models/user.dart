class CustomUser {
  final String uid;
  String country;
  String name;
  List<String> fields = [];
  bool isUni;

  // auto applied die übergebene uid zu uid
  CustomUser({this.uid});

  void updateCountry(String newCountry) {
    country = newCountry;
  }

  void updateName(String newName) {
    name = newName;
  }

  void addFields(List<String> newFields) {
    fields.addAll(newFields);
  }

  void removeFields(List<String> deletedFields) {
    deletedFields.forEach((element) {fields.remove(element);});
  }

  void setIsUni(bool newIsUni) {
    isUni = newIsUni;
  }

  Map<String, dynamic> getFieldsAsMaps(){
    return {
      "country": country,
      "name": name,
      "uId": uid,
      "isUni": isUni,
      "field": fields
    };
  }

}