class Member {
  String _name;
  String _objectId;
  Member({String name, String objectId}) {
    this._name = name;
    this._objectId = objectId;
  }
  Member.fromJson(Map<String, dynamic> jsonObject) {
    _name = jsonObject["Name"].toString();
    _objectId = jsonObject["objectId"].toString();
  }
  Map<dynamic, dynamic> toJson() {
    return {"Name": this._name, "objectId": this._objectId};
  }

  get name => this._name;
  get objectId => this._objectId;
}
