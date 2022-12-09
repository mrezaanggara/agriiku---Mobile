import 'package:agriiku/model/type_model.dart';
import 'package:http/http.dart' as http;

class TypeApiService {
  Future<List<Type>?> getType() async {
    final response = await http.get(
        Uri.parse("https://staging-agriku.headmasters.id/api/dashboard/jenis"));
    if (response.statusCode == 200) {
      return typeFromJson(response.body);
    }
    return null;
  }
}
