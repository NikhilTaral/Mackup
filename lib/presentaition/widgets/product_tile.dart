import 'package:flutter/material.dart';
import 'package:fast/data/module/product.dart_module.dart';
import 'package:get/get.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final Function(Product) onAddToCart;
  final Function(Product) removeToCart;

  const ProductTile(this.product,
      {super.key, required this.onAddToCart, required this.removeToCart});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: 100,
      child: Card(
        elevation: 20,
        shadowColor: Colors.grey.shade400,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.network(
                      product.imageLink,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Obx(() => CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: product.isFavorite.value
                                ? const Icon(Icons.favorite_rounded)
                                : const Icon(Icons.favorite_border),
                            onPressed: () {
                              if (product.isFavorite.value) {
                                removeToCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${product.name} removed from cart'),
                                  ),
                                );
                              } else {
                                onAddToCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('${product.name} added to cart'),
                                  ),
                                );
                              }

                              product.isFavorite.toggle();
                            },
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text('\$${product.price}',
                  style: const TextStyle(fontSize: 22, fontFamily: 'avenir')),
            ],
          ),
        ),
      ),
    );
  }
}
