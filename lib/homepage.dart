import 'package:fast/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_controller.dart';
import 'product_tile.dart';
import 'cart_page.dart';

class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void addToCart(Product product) {
      productController.addToCart(product);
    }

    int calculateCrossAxisCount(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      int crossAxisCount = (screenWidth / 200).floor();
      return crossAxisCount;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              final selectedProducts = productController.cartItems;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cartItems: selectedProducts),
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Product List',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: calculateCrossAxisCount(context),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1 / 1.5,
                  ),
                  itemCount: productController.productList.length,
                  itemBuilder: (context, i) => ProductTile(
                    productController.productList[i],
                    onAddToCart: addToCart,
                  ),
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
