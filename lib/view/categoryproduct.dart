import 'package:flutter/material.dart';
import 'package:agriiku/model/allproduct_model.dart';
import 'package:agriiku/style/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'detail/detailproduct.dart';

class CategoryProduct extends StatefulWidget {
  final String keyword;
  const CategoryProduct({required this.keyword, Key? key}) : super(key: key);

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  int currentPage = 1;
  int limit = 6;
  List<Product> product = [];
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> getProductsData({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    }

    final Uri uri = Uri.parse(
        "http://172.18.10.88/agrii-ku/api/product/bycategory?pages=$currentPage&limit=$limit&keyword=${widget.keyword}");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final result = productDataFromJson(response.body);
      if (isRefresh) {
        product = result.data!;
      } else {
        product.addAll(result.data!);
      }
      currentPage++;
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori Produk : ${widget.keyword}'),
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = getProductsData(isRefresh: true);
          if (await result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = getProductsData();
          if (await result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        header: const WaterDropHeader(),
        footer: CustomFooter(builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const Text("No more data.");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("release to load more");
          } else {
            body = const Text("No more Data");
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        }),
        child: GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 350,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: product.length,
            itemBuilder: ((context, index) {
              Product? p = product[index];
              String url = "http://172.18.10.88/agrii-ku/data/images/product/";
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => DetailProduct(
                              id: (p.id ?? ''), key: ValueKey(p.id))));
                },
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(1.0),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              child: Image.network(url + (p.maingambar ?? ''),
                                  fit: BoxFit.fill,
                                  height: 180,
                                  width: 1000.0)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            p.nama ?? "",
                            style: h3Style,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            (p.harga ?? ''),
                            style: h4Style,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Divider(
                            color: Colors.grey[400],
                            thickness: 1,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: p.stok != "0"
                                ? SizedBox(
                                    child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    width: 85,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF248b3c),
                                      borderRadius: BorderRadius.circular(5),
                                      //border: Border.all(color: Colors.green)
                                    ),
                                    child: Text(
                                      "Stok | ${p.stok ?? ""}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ))
                                : SizedBox(
                                    child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    width: 85,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent[700],
                                      borderRadius: BorderRadius.circular(5),
                                      //border: Border.all(color: Colors.green)
                                    ),
                                    child: const Text(
                                      "Stok | Habis",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ))),
                      ]),
                ),
              );
            })),
      ),
    );
  }
}
