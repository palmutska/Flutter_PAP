// ignore_for_file: unnecessary_getters_setters

class Meal {
  DateTime? _data;
  String? _local;
  String? _tipo;
  String? _especial;

  Meal({DateTime? datas, String? local, String? tipo, String? especial}) {
    if (datas != null) {
      _data = datas;
    }
    if (local != null) {
      _local = local;
    }
    if (tipo != null) {
      _tipo = tipo;
    }
    if (especial != null) {
      _especial = especial;
    }
  }

  DateTime? get data => _data;
  set data(DateTime? data) => _data = data;
  String? get local => _local;
  set local(String? local) => _local = local;
  String? get tipo => _tipo;
  set tipo(String? tipo) => _tipo = tipo;
  String? get especial => _especial;
  set especial(String? especial) => _especial = especial;

  Meal.fromJson(Map<String, dynamic> json) {
    _data = json['datas'];
    _local = json['local'];
    _tipo = json['tipo'];
    _especial = json['especial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['datas'] = _data;
    data['local'] = _local;
    data['tipo'] = _tipo;
    data['especial'] = _especial;
    return data;
  }

  @override
  String toString() {
    String s = "";
    s += "Local: " + local.toString();
    s += "\nTipo: " + tipo.toString();
    s += "\nEspecial: " + especial.toString();
    return s;
  }
}
