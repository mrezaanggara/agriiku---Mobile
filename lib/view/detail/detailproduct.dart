import 'package:agriiku/database/db_helper.dart';
import 'package:agriiku/model/cart_model.dart';
import 'package:agriiku/model/product_model.dart';
import 'package:agriiku/provider/cart_provider.dart';
import 'package:agriiku/service/product_service.dart';
import 'package:agriiku/style/currencyformat.dart';
import 'package:agriiku/style/text_style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailProduct extends StatefulWidget {
  final String id;
  const DetailProduct({required this.id, Key? key}) : super(key: key);

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  late ProductApiService apiService;
  DBHelper dbHelper = DBHelper();
  Product? p;
  Gambar? g;
  late int _quantity = 0;
  late int _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    apiService = ProductApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: apiService.getProduct(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [Text("Server sedang bermasalah.")],
            ));
          } else if (snapshot.connectionState == ConnectionState.done) {
            p = snapshot.data;
            return SafeArea(
              child: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: 428,
                        leading: IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            color: Color(0xff80a571),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                              color: const Color(0xFFeeeeee),
                              child: CarouselSlider.builder(
                                itemCount: p!.gambar?.length,
                                itemBuilder: ((context, index, realIndex) {
                                  g = p!.gambar?[index];
                                  String url =
                                      "https://staging-agriku.headmasters.id/data/images/product/";
                                  return Stack(
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.all(1.0),
                                        child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10.0)),
                                            child: Image.network(
                                              url + (g!.gambar ?? ""),
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ],
                                  );
                                }),
                                options: CarouselOptions(
                                  height: 200,
                                  enableInfiniteScroll: false,
                                  autoPlay: false,
                                  aspectRatio: 2.5,
                                  viewportFraction: 1,
                                ),
                              )),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ..._buildTitle(
                                  p?.visitor, p?.nama, p?.harga, p?.stok),
                              const SizedBox(height: 16),
                              _buildLine(),
                              const SizedBox(height: 16),
                              ..._buildDescription(),
                              const SizedBox(height: 24),
                              _buildQuantity(),
                              const SizedBox(height: 115),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buldFloatBar()
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  List<Widget> _buildTitle(
      String? visitor, String? nama, String? harga, String? stok) {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Text(
              nama ?? '',
              style: h1Style,
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Text(
              CurrencyFormat.convertToIdr(int.parse(harga ?? ''), 2),
              style: h5Style,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: Color(0xFFeeeeee),
            ),
            child: Text(
              '${visitor ?? ''} views',
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 16),
          const FaIcon(
            FontAwesomeIcons.boxOpen,
            size: 20,
            color: Color(0xff80a571),
          ),
          const SizedBox(width: 8),
          Text(
            'Stok | ${stok ?? ''}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: InkWell(
              onTap: () {
                launchUrl(
                  Uri.parse('https://www.youtube.com/watch?v=${p?.video}'),
                  mode: LaunchMode.externalApplication,
                );
              },
              child: p?.video != ''
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: Color(0xFFeeeeee),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.youtube,
                            color: Color.fromRGBO(213, 0, 0, 1),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Video Produk',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ))
                  : const Padding(padding: EdgeInsets.all(1)),
            ),
          )
        ],
      ),
    ];
  }

  Widget _buildLine() {
    return Container(height: 1, color: const Color(0xFFEEEEEE));
  }

  List<Widget> _buildDescription() {
    return [
      const Text('Description',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      ExpandableText(
        p?.deskripsi ?? '',
        expandText: 'view more',
        collapseText: 'view less',
        maxLines: 3,
        textAlign: TextAlign.justify,
        linkStyle: const TextStyle(
            color: Color(0xFF424242), fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      const Text('Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${p?.kategori ?? ''}, ${p?.jenis ?? ''}'),
          const SizedBox(height: 8),
          const Text('Dimensi Produk',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Panjang : ${p?.panjang ?? ''} cm'),
              Text('Tinggi : ${p?.tinggi ?? ''} cm'),
              Text('Lebar : ${p?.lebar ?? ''} cm'),
            ],
          )
        ],
      )
    ];
  }

  Widget _buildQuantity() {
    return Row(
      children: [
        const Text('Quantity',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(width: 20),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            color: Color(0xFFF3F3F3),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                InkWell(
                  child: const FaIcon(
                    FontAwesomeIcons.minus,
                    size: 12,
                  ),
                  onTap: () {
                    if (_quantity <= 0) return;
                    setState(() {
                      _quantity -= 1;
                      _totalPrice -= int.parse(p?.harga ?? '');
                    });
                  },
                ),
                const SizedBox(width: 20),
                Text('$_quantity',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                const SizedBox(width: 20),
                InkWell(
                  child: const FaIcon(
                    FontAwesomeIcons.plus,
                    size: 12,
                  ),
                  onTap: () {
                    setState(() {
                      _quantity += 1;
                      _totalPrice += int.parse(p?.harga ?? '');
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buldFloatBar() {
    final cart = Provider.of<CartProvider>(context);

    buildAddCard() => Container(
          height: 58,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: const Color(0xff80a571),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 20,
                color: const Color(0xff80a571).withOpacity(0.25),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              // splashColor: const Color(0xFFEEEEEE),
              onTap: () {
                dbHelper
                    .insert(
                  Cart(
                    productId: int.parse(p?.id ?? ''),
                    productName: p?.nama,
                    initialPrice: int.parse(p?.harga ?? ''),
                    productPrice: _totalPrice,
                    quantity: _quantity,
                  ),
                )
                    .then((value) {
                  cart.addTotalPrice(_totalPrice.toDouble());
                  cart.addCounter();

                  Product data = Product();
                  data.id = p?.id;
                  data.stok = (int.parse(p?.stok ?? '') - _quantity).toString();

                  apiService.updateStock(data);
                }).onError((error, stackTrace) {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  FaIcon(
                    FontAwesomeIcons.cartPlus,
                    color: Colors.white,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

    buildEmptyCard() => Container(
          height: 58,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: Colors.redAccent[700],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              // splashColor: const Color(0xFFEEEEEE),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Stok habis'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Stok Habis',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            _buildLine(),
            const SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total price',
                        style:
                            TextStyle(color: Color(0xFF757575), fontSize: 12)),
                    const SizedBox(height: 6),
                    Text(CurrencyFormat.convertToIdr(_totalPrice, 2),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ],
                ),
                p?.stok != '0' ? buildAddCard() : buildEmptyCard()
              ],
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
