import 'package:agriiku/model/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryApiService {
  Future<List<Category>?> getCategory() async {
    final response = await http
        .get(Uri.parse("http://172.18.10.95/agrii-ku/api/dashboard/kategori"));
    if (response.statusCode == 200) {
      return categoryFromJson(response.body);
    }
    return null;
  }
}