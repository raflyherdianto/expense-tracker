// ignore_for_file: unnecessary_this

class User {
  late int id;
  late String _name;
  late String _username;
  late String _password;

  User(this._name, this._username, this._password);

  User.map(dynamic obj) {
    this._name = obj['name'];
    this._username = obj['username'];
    this._password = obj['password'];
  }

  String get name => _name;
  String get username => _username;
  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['name'] = _name;
    map['username'] = _username;
    map['password'] = _password;
    return map;
  }

  void setUserId(int id) {
    this.id = id;
  }
}
