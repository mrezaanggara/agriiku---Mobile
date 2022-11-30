import 'dart:convert';

class Carousel {
  String? carousel;

  Carousel({this.carousel});

  Carousel.fromJson(Map<String, dynamic> json) {
    carousel = json['carousel'];
  }
}

List<Carousel> carouselFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Carousel>.from(data.map((item) => Carousel.fromJson(item)));
}
