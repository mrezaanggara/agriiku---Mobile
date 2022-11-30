import 'dart:convert';

class Type {
  String? id;
  String? jenis;
  String? status;

  Type({this.id, this.jenis, this.status});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jenis = json['jenis'];
    status = json['status'];
  }
}

List<Type> typeFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Type>.from(data.map((item) => Type.fromJson(item)));
}
