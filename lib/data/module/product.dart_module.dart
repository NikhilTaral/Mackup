import 'dart:convert';

import 'package:get/get.dart';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.name,
    required this.price,
    required this.imageLink,
  });

  String name;
  dynamic price;

  String imageLink;

  var isFavorite = false.obs;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        price: json["price"],
        imageLink: json["image_link"],
      );

  get isSelected => null;

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "image_link": imageLink,
      };
}
