import 'package:agriiku/model/carousel_model.dart';
import 'package:agriiku/service/carousel_service.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerIklan extends StatefulWidget {
  const BannerIklan({super.key});

  @override
  State<BannerIklan> createState() => _BannerIklanState();
}

class _BannerIklanState extends State<BannerIklan> {
  late CarouselApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = CarouselApiService();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiService.getCarousel(),
        builder: (context, snapshot) {
          final List<Carousel>? carousel = snapshot.data;
          if (snapshot.hasError) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [Text("Server sedang bermasalah.")],
            ));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return CarouselSlider.builder(
              itemCount: carousel?.length,
              itemBuilder: ((context, index, realIndex) {
                Carousel? c = carousel![index];
                String url =
                    "http://172.18.10.95/agrii-ku/data/images/carousel/";
                return Stack(
                  children: <Widget>[
                    Container(
                      height: 300,
                      margin: const EdgeInsets.all(1.0),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child: Image.network(url + (c.carousel ?? ""),
                              fit: BoxFit.fill, width: 1000.0)),
                    )
                  ],
                );
              }),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.5,
                viewportFraction: 1,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
