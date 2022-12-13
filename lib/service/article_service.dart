import 'package:agriiku/model/article_model.dart';
import 'package:http/http.dart' as http;

class ArticleApiService {
  Future<List<Article>?> getArticles() async {
    final response = await http
        .get(Uri.parse("https://agri-iku.headmasters.id//api/article"));
    if (response.statusCode == 200) {
      return articleFromJson(response.body);
    }
    return null;
  }

  // Future<Article?> getArticle(String id) async {
  //   final response = await http
  //       .get(Uri.parse('https://agri-iku.headmasters.id//api/article?id=$id'));
  //   if (response.statusCode == 200) {
  //     return Article.fromJson(json.decode(response.body)['data']);
  //   }
  //   return null;
  // }
}
