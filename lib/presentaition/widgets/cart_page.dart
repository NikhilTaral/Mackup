import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/module/product.dart_module.dart';

class cart_page extends StatelessWidget {
  final RxList<Product> cartItems;

  const cart_page({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final product = cartItems[index];
              return ListTile(
                leading: Image.network(
                  product.imageLink,
                  height: 200,
                  width: 120,
                  fit: BoxFit.cover,
                ),
                title: Text(product.name),
                subtitle: Text('Price: \$${product.price}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    removeFromCart(product);
                  },
                ),
              );
            },
          ),
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 12,
                  ),
                  onPressed: () {},
                  child: const Text('Checkout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  double _calculateTotalPrice() {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += double.parse(item.price);
    }
    return totalPrice;
  }
}
