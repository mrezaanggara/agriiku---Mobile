import 'package:agriiku/model/article_model.dart';
import 'package:http/http.dart' as http;

class ArticleApiService {
  Future<List<Article>?> getArticles() async {
    final response =
        await http.get(Uri.parse("http://172.18.10.88/agrii-ku/api/article"));
    if (response.statusCode == 200) {
      return articleFromJson(response.body);
    }
    return null;
  }

  // Future<Article?> getArticle(String id) async {
  //   final response = await http
  //       .get(Uri.parse('http://172.18.10.88/agrii-ku/api/article?id=$id'));
  //   if (response.statusCode == 200) {
  //     return Article.fromJson(json.decode(response.body)['data']);
  //   }
  //   return null;
  // }
}
