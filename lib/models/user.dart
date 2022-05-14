// ignore_for_file: unnecessary_getters_setters

class User {
  String? _id;
  String? _name;
  String? _nif;
  String? _num;
  String? _regime;
  String? _tickets;
  String? _type;
  String? _vegetariano;
  String? _dieta;

  User(
      {String? id,
      String? name,
      String? nif,
      String? num,
      String? regime,
      String? tickets,
      String? type,
      String? vegetariano,
      String? dieta}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (nif != null) {
      _nif = nif;
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
    if (vegetariano != null) {
      _vegetariano = vegetariano;
    }
    if (dieta != null) {
      _dieta = dieta;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get nif => _nif;
  set nif(String? nif) => _nif = nif;
  String? get num => _num;
  set num(String? numNim) => _num = numNim;
  String? get regime => _regime;
  set regime(String? regime) => _regime = regime;
  String? get tickets => _tickets;
  set tickets(String? tickets) => _tickets = tickets;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get vegetariano => _vegetariano;
  set vegetariano(String? vegetariano) => _vegetariano = vegetariano;
  String? get dieta => _dieta;
  set dieta(String? dieta) => _dieta = dieta;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _nif = json['nif'];
    _num = json['num'];
    _regime = json['regime'];
    _tickets = json['tickets'];
    _type = json['type'];
    _vegetariano = json['vegetariano'];
    _dieta = json['dieta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['nif'] = _nif;
    data['num'] = _num;
    data['regime'] = _regime;
    data['tickets'] = _tickets;
    data['type'] = _type;
    data['vegetariano'] = _vegetariano;
    data['dieta'] = _dieta;
    return data;
  }
}
