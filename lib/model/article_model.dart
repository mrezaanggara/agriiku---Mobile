import 'dart:convert';

class Article {
  String? id;
  String? title;
  String? content;
  String? tanggal;

  Article({this.id, this.title, this.content, this.tanggal});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    tanggal = json['tanggal'];
  }
}

List<Article> articleFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Article>.from(data.map((item) => Article.fromJson(item)));
}
