import 'package:fast/presentaition/widgets/cart_page.dart';
import 'package:fast/data/module/product.dart_module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/product_controller.dart';
import '../widgets/product_tile.dart';

class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void addToCart(Product product) {
      productController.addToCart(product);
    }

    void removeToCart(Product product) {
      productController.removeToCart(product);
    }

    int calculateCrossAxisCount(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      int crossAxisCount = (screenWidth / 200).floor();
      return crossAxisCount;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 22, left: 12),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
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
                    builder: (context) =>
                        cart_page(cartItems: selectedProducts),
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
                      removeToCart: removeToCart,
                    ),
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
