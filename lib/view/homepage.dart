import 'package:agriiku/model/category_model.dart';
import 'package:agriiku/model/type_model.dart';
import 'package:agriiku/service/category_service.dart';
import 'package:agriiku/service/type_service.dart';
import 'package:agriiku/view/widget/mostviewproduct.dart';
import 'package:agriiku/view/widget/newproduct.dart';
import 'package:flutter/material.dart';
import 'package:agriiku/style/text_style.dart';
import 'widget/banner.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late CategoryApiService apiService;
  late TypeApiService apiService2;

  @override
  void initState() {
    super.initState();
    apiService = CategoryApiService();
    apiService2 = TypeApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: <Widget>[
          Image.asset(
            'assets/images/agriiku.png',
            height: 50,
            alignment: Alignment.centerLeft,
          ),
          const SizedBox(
            height: 15,
          ),
          const BannerIklan(),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            height: 130,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("Kategori & Jenis",
                      style: TextStyle(
                          fontFamily: "Nunito", fontWeight: FontWeight.bold)),
                ),
                _category(),
                _type()
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Produk Terbaru",
            style: h2Style,
          ),
          const SizedBox(
            height: 10,
          ),
          const NewProduct(),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Produk Sering Dilihat",
            style: h2Style,
          ),
          const SizedBox(
            height: 10,
          ),
          const MostViewProduct()
        ],
      ),
    ));
  }

  Widget _category() {
    return FutureBuilder(
        future: apiService.getCategory(),
        builder: (context, snapshot) {
          final List<Category>? category = snapshot.data;
          return snapshot.hasError
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [Text("Server sedang bermasalah.")],
                ))
              : snapshot.connectionState == ConnectionState.done
                  ? Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      height: 50,
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: (1 / 1.8),
                          ),
                          itemCount: category?.length,
                          itemBuilder: ((context, index) {
                            Category? c = category![index];
                            return TextButton(
                                onPressed: () {},
                                child: Text(
                                  c.kategori ?? "",
                                  style: const TextStyle(fontSize: 10),
                                ));
                          })))
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
        });
  }

  Widget _type() {
    return FutureBuilder(
        future: apiService2.getType(),
        builder: (context, snapshot) {
          final List<Type>? type = snapshot.data;
          return snapshot.hasError
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [Text("Server sedang bermasalah.")],
                ))
              : snapshot.connectionState == ConnectionState.done
                  ? Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      height: 50,
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: (1 / 1.8),
                          ),
                          itemCount: type?.length,
                          itemBuilder: ((context, index) {
                            Type? t = type![index];
                            return TextButton(
                              onPressed: () {},
                              child: Text(
                                t.jenis ?? "",
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          })))
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
        });
  }
}