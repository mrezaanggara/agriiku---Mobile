import 'package:agriiku/model/carousel_model.dart';
import 'package:http/http.dart' as http;

class CarouselApiService {
  Future<List<Carousel>?> getCarousel() async {
    final response = await http
        .get(Uri.parse("http://172.18.10.95/agrii-ku/api/dashboard/carousel"));
    if (response.statusCode == 200) {
      return carouselFromJson(response.body);
    }
    return null;
  }
}