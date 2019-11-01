import 'package:flutter/material.dart';

class Product {
  String id;
  String title;
  String image;
  String description;
  double price;
  final bool isFavourite;
  final String userEmail;
  final String userId;

  Product({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.price,
    this.description,
    this.isFavourite,
    @required this.userEmail,
    @required this.userId,
  });

  Product.fromProduct(Product from, this.isFavourite)
      : this.title = from.title,
        this.id = from.id,
        this.description = from.description,
        this.image = from.image,
        this.userEmail = from.userEmail,
        this.userId = from.userEmail,
        this.price = from.price;
}
