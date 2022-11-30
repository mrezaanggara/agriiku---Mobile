import 'dart:convert';

ProductData productDataFromJson(String str) =>
    ProductData.fromJson(json.decode(str));
String productDataToJson(ProductData data) => jsonEncode(data.toJson());

class ProductData {
  bool? status;
  List<Product>? data;

  ProductData({this.status, this.data});

  ProductData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? id;
  String? nama;
  String? harga;
  String? kategori;
  String? stok;
  String? maingambar;

  Product(
      {this.id,
      this.nama,
      this.harga,
      this.kategori,
      this.stok,
      this.maingambar});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    harga = json['harga'];
    kategori = json['kategori'];
    stok = json['stok'];
    maingambar = json['maingambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['harga'] = harga;
    data['kategori'] = kategori;
    data['stok'] = stok;
    data['maingambar'] = maingambar;
    return data;
  }
}
