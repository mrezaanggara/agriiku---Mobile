import 'package:agriiku/model/type_model.dart';
import 'package:http/http.dart' as http;

class TypeApiService {
  Future<List<Type>?> getType() async {
    final response = await http
        .get(Uri.parse("http://172.18.10.95/agrii-ku/api/dashboard/jenis"));
    if (response.statusCode == 200) {
      return typeFromJson(response.body);
    }
    return null;
  }
}