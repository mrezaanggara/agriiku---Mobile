import 'package:agriiku/style/text_style.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hoverColor: Colors.white,
            hintText: "Cari Produk...",
            hintStyle: const TextStyle(color: Colors.white),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            contentPadding: const EdgeInsets.all(5),
            enabledBorder: textFieldStyle,
            focusedBorder: textFieldStyle),
      ),
    );
  }
}