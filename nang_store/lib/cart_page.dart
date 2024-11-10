import 'package:flutter/material.dart';
import 'package:nang_store/cart_control.dart';
import 'package:nang_store/home_pages.dart';
import 'package:provider/provider.dart';

class CartListScreen extends StatelessWidget {
  const CartListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Your Cart"),
      ),
      body: Consumer<HandlerCart>(
        builder: (context, cart, child) {
          final cartItems = cart.items.values.toList();
          return cartItems.isEmpty
              ? const Center(
            child: Text(
              "Your cart is empty!",
              style: TextStyle(fontSize: 18),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: cartItems.length,
            itemBuilder: (ctx, i) {
              final item = cartItems[i];
              final totalPrice = item.product.price * item.qty;
              return Card(
                color: Colors.grey[100],
                margin: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  leading: Image.network(
                    urlApi + item.product.image,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      );
                    },
                  ),
                  title: Text(
                    item.product.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    'Qty: ${item.qty} | Total: \$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline, color: Colors.red[700]),
                    onPressed: () {
                      cart.removeOneItem(item.product.id.toString());
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
