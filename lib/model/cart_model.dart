class Cart {
  int? id;
  int? productId;
  String? productName;
  int? initialPrice;
  int? productPrice;
  int? quantity;

  Cart(
      {this.id,
      this.productId,
      this.productName,
      this.initialPrice,
      this.productPrice,
      this.quantity});

  Cart.fromMap(Map<dynamic, dynamic> data)
      : productId = int.parse(data['productId']),
        productName = data['productName'],
        initialPrice = data['initialPrice'],
        productPrice = data['productPrice'],
        quantity = data['quantity'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity,
    };
  }

  Map<String, dynamic> quantityMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
