import 'package:agriiku/model/carousel_model.dart';
import 'package:agriiku/service/carousel_service.dart';
import 'package:agriiku/style/shimmer.dart';
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
            return Stack(
              children: <Widget>[
                Container(
                    height: 140,
                    margin: const EdgeInsets.all(1.0),
                    child: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: CustomWidget.rectangular(
                        height: 300,
                      ),
                    ))
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return CarouselSlider.builder(
              itemCount: carousel?.length,
              itemBuilder: ((context, index, realIndex) {
                Carousel? c = carousel![index];
                String url =
                    "https://agri-iku.headmasters.id//data/images/carousel/";
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
            return Stack(
              children: <Widget>[
                Container(
                    height: 140,
                    margin: const EdgeInsets.all(1.0),
                    child: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: CustomWidget.rectangular(
                        height: 300,
                      ),
                    ))
              ],
            );
          }
        });
  }
}
