import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'dart:io' as io;
import 'package:agriiku/model/cart_model.dart';

class DBHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = p.join(directory.path, 'carts.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT, productId VARCHAR, productName TEXT, initialPrice INTEGER, productPrice INTEGER, quantity INTEGER)');
  }

  Future<Cart> insert(Cart cart) async {
    var dbClient = await database;
    await dbClient?.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getCartList() async {
    var dbClient = await database;

    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cart');
    return queryResult.map((result) => Cart.fromMap(result)).toList();
  }

  Future<int?> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient
        ?.delete('cart', where: 'productID = ?', whereArgs: [id]);
  }

  Future<int> updateQuantity(Cart cart) async {
    var dbClient = await database;
    return await dbClient!.update('cart', cart.quantityMap(),
        where: "productId = ?", whereArgs: [cart.productId]);
  }

  Future<List<Cart>> getCartId(int id) async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryIdResult =
        await dbClient!.query('cart', where: 'id = ?', whereArgs: [id]);
    return queryIdResult.map((e) => Cart.fromMap(e)).toList();
  }
}
