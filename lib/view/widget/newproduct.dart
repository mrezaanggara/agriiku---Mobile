import 'package:agriiku/model/product_model.dart';
import 'package:agriiku/service/product_service.dart';
import 'package:agriiku/style/shimmer.dart';
import 'package:agriiku/style/text_style.dart';
import 'package:agriiku/view/detail/detailproduct.dart';
import 'package:flutter/material.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({super.key});

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  late ProductApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ProductApiService();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiService.getNewProducts(),
        builder: (context, snapshot) {
          final List<Product>? product = snapshot.data;
          return snapshot.hasError
              ? Container(
                  height: 350,
                  margin: const EdgeInsets.all(1.0),
                  child: const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: CustomWidget.rectangular(
                      height: 300,
                    ),
                  ))
              : snapshot.connectionState == ConnectionState.done
                  ? SizedBox(
                      height: 350,
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          //shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1, mainAxisExtent: 180),
                          itemCount: product?.length,
                          itemBuilder: ((context, index) {
                            Product? p = product![index];
                            String url =
                                "https://staging-agriku.headmasters.id//agrii-ku/data/images/product/";
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            DetailProduct(
                                                id: (p.id ?? ''),
                                                key: ValueKey(p.id))));
                              },
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(1.0),
                                        child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10.0)),
                                            child: Image.network(
                                                url + (p.maingambar ?? ''),
                                                fit: BoxFit.fill,
                                                height: 180,
                                                width: 1000.0)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          p.nama ?? "",
                                          style: h3Style,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Text(
                                          p.harga ?? "",
                                          style: h4Style,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 5, 15, 5),
                                        child: Divider(
                                          color: Colors.grey[400],
                                          thickness: 1,
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: p.stok != "0"
                                              ? SizedBox(
                                                  child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  width: 85,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF248b3c),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    //border: Border.all(color: Colors.green)
                                                  ),
                                                  child: Text(
                                                    "Stok | ${p.stok ?? ""}",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Nunito",
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ))
                                              : SizedBox(
                                                  child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  width: 85,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.redAccent[700],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    //border: Border.all(color: Colors.green)
                                                  ),
                                                  child: const Text(
                                                    "Stok | Habis",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Nunito",
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ))),
                                    ]),
                              ),
                            );
                          })))
                  : Container(
                      height: 350,
                      margin: const EdgeInsets.all(1.0),
                      child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: CustomWidget.rectangular(
                          height: 300,
                        ),
                      ));
        });
  }
}
