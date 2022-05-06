// ignore_for_file: unnecessary_getters_setters

class User {
  String? _id;
  String? _name;
  String? _num;
  String? _regime;
  String? _tickets;
  String? _type;

  User(
      {String? id,
      String? name,
      String? num,
      String? regime,
      String? tickets,
      String? type}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (num != null) {
      _num = num;
    }
    if (regime != null) {
      _regime = regime;
    }
    if (tickets != null) {
      _tickets = tickets;
    }
    if (type != null) {
      _type = type;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get num => _num;
  set num(String? num) => _num = num;
  String? get regime => _regime;
  set regime(String? regime) => _regime = regime;
  String? get tickets => _tickets;
  set tickets(String? tickets) => _tickets = tickets;
  String? get type => _type;
  set type(String? type) => _type = type;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _num = json['num'];
    _regime = json['regime'];
    _tickets = json['tickets'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['num'] = _num;
    data['regime'] = _regime;
    data['tickets'] = _tickets;
    data['type'] = _type;
    return data;
  }
}
