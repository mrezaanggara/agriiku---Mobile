import 'package:agriiku/model/type_model.dart';
import 'package:http/http.dart' as http;

class TypeApiService {
  Future<List<Type>?> getType() async {
    final response = await http
        .get(Uri.parse("http://172.20.10.2/agrii-ku/api/dashboard/jenis"));
    if (response.statusCode == 200) {
      return typeFromJson(response.body);
    }
    return null;
  }
}
