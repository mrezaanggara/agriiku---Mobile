import 'dart:convert';
import 'package:agriiku/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductApiService {
  Future<Product?> getProduct(String id) async {
    final response = await http.get(Uri.parse(
        'https://staging-agriku.headmasters.id//agrii-ku/api/product/detailproduct?id=$id'));
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body)['data']);
    }
    return null;
  }

  Future<List<Product>?> getNewProducts() async {
    final response = await http.get(Uri.parse(
        "https://staging-agriku.headmasters.id//agrii-ku/api/product/newproduct"));
    if (response.statusCode == 200) {
      return productFromJson(response.body);
    }
    return null;
  }

  Future<List<Product>?> getMostViewProducts() async {
    final response = await http.get(Uri.parse(
        "https://staging-agriku.headmasters.id//agrii-ku/api/product/mostviewproduct"));
    if (response.statusCode == 200) {
      return productFromJson(response.body);
    }
    return null;
  }

  Future<bool> updateStock(Product data) async {
    final response = await http.put(
        Uri.parse(
            'https://staging-agriku.headmasters.id//agrii-ku/api/product/updatestock'),
        body: {'id': data.id, 'stok': data.stok});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> reverseStock(Product data) async {
    final response = await http.put(
        Uri.parse(
            'https://staging-agriku.headmasters.id//agrii-ku/api/product/reversestock'),
        body: {'id': data.id, 'stok': data.stok});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
