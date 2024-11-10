import 'package:nang_store/model/product.dart';

class CartList {
  final String id;
  final Product product;
  int qty;

  CartList({
    required this.id,
    required this.product,
    this.qty = 1,
  });

  double get price => product.price;
}
