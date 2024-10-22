import 'package:agriiku/model/carousel_model.dart';
import 'package:http/http.dart' as http;

class CarouselApiService {
  Future<List<Carousel>?> getCarousel() async {
    final response = await http.get(
        Uri.parse("https://agri-iku.headmasters.id//api/dashboard/carousel"));
    if (response.statusCode == 200) {
      return carouselFromJson(response.body);
    }
    return null;
  }
}
