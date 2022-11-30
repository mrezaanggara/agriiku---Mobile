import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:agriiku/view/widget/searchbox.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'product.dart';
import 'article.dart';
import 'cart.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = <Widget>[
    const Homepage(),
    const Allproducts(),
    const ArticlePage(),
    const CartScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.green,
          toolbarHeight: 70,
          bottomOpacity: 0.2,
          title: const SearchBox(),
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.only(top: 100),
            children: [
              ListTile(
                title: const Text("Tentang kami"),
                onTap: () {},
              ),
              ListTile(
                title: const Text("Cara Penggunaan"),
                onTap: () {},
              )
            ],
          ),
        ),
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showUnselectedLabels: false,
          elevation: 0,
          //fixedColor: Colors.green,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house), label: 'Home'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.boxOpen), label: 'Product'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.newspaper), label: 'Article'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.cartShopping), label: 'Cart'),
          ],
        ));
  }
}
