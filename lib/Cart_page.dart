import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product.dart';

class CartPage extends StatelessWidget {
  final RxList<Product> cartItems;

  const CartPage({super. key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Obx(() {
        final List<Product> addedProducts = cartItems.toList();
        return ListView.builder(
          itemCount: addedProducts.length,
          itemBuilder: (context, index) {
            final product = addedProducts[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('Price: \$${product.price}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _removeProduct(index);
                },
              ),
            );
          },
        );
      }),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text(
                    'Total: \$${_calculateTotalPrice().toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              ElevatedButton(
                onPressed: () {},
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateTotalPrice() {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += double.parse(item.price);
    }
    return totalPrice;
  }

  void _removeProduct(int index) {
    cartItems.removeAt(index);
  }
}
