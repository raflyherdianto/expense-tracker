class Cashflow {
  late int id;
  late String _date;
  late int _cash;
  late String _description;
  late String _type;

  Cashflow(this._date, this._cash, this._description, this._type);

  Cashflow.map(dynamic obj) {
    this._date = obj['date'];
    this._cash = obj['cash'];
    this._description = obj['description'];
    this._type = obj['type'];
  }

  String get date => _date;
  int get cash => _cash;
  String get description => _description;
  String get type => _type;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['date'] = _date;
    map['cash'] = _cash;
    map['description'] = _description;
    map['type'] = _type;
    return map;
  }

  void setCashflowId(int id) {
    this.id = id;
  }
}
