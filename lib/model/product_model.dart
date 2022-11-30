import "dart:convert";

class Product {
  String? id;
  String? nama;
  String? visitor;
  String? harga;
  String? jenis;
  String? kategori;
  String? stok;
  String? status;
  String? berat;
  String? deskripsi;
  String? video;
  String? maingambar;
  List<Gambar>? gambar;
  String? panjang;
  String? lebar;
  String? tinggi;

  Product(
      {this.id,
      this.nama,
      this.visitor,
      this.harga,
      this.jenis,
      this.kategori,
      this.stok,
      this.status,
      this.berat,
      this.deskripsi,
      this.video,
      this.maingambar,
      this.gambar,
      this.panjang,
      this.lebar,
      this.tinggi});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    visitor = json['visitor'];
    harga = json['harga'];
    jenis = json['jenis'];
    kategori = json['kategori'];
    stok = json['stok'];
    status = json['status'];
    berat = json['berat'];
    deskripsi = json['deskripsi'];
    video = json['video'];
    maingambar = json['maingambar'];
    if (json['gambar'] != null) {
      gambar = <Gambar>[];
      json['gambar'].forEach((v) {
        gambar!.add(Gambar.fromJson(v));
      });
    }
    panjang = json['panjang'];
    lebar = json['lebar'];
    tinggi = json['tinggi'];
  }
}

class Gambar {
  String? gambar;
  String? idProduk;

  Gambar({this.gambar, this.idProduk});

  Gambar.fromJson(Map<String, dynamic> json) {
    gambar = json['gambar'];
    idProduk = json['id_produk'];
  }
}

List<Product> productFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Product>.from(data.map((item) => Product.fromJson(item)));
}
