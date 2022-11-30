import 'dart:convert';

class Category {
  String? id;
  String? kategori;
  String? status;

  Category({this.id, this.kategori, this.status});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kategori = json['kategori'];
    status = json['status'];
  }
}

List<Category> categoryFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Category>.from(data.map((item) => Category.fromJson(item)));
}
