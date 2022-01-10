// ignore_for_file: unnecessary_getters_setters

class Meal {
  String? _data;
  String? _local;
  String? _tipo;

  Meal({String? data, String? local, String? tipo}) {
    if (data != null) {
      _data = data;
    }
    if (local != null) {
      _local = local;
    }
    if (tipo != null) {
      _tipo = tipo;
    }
  }

  String? get data => _data;
  set data(String? data) => _data = data;
  String? get local => _local;
  set local(String? local) => _local = local;
  String? get tipo => _tipo;
  set tipo(String? tipo) => _tipo = tipo;

  Meal.fromJson(Map<String, dynamic> json) {
    _data = json['data'];
    _local = json['local'];
    _tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = _data;
    data['local'] = _local;
    data['tipo'] = _tipo;
    return data;
  }
}
