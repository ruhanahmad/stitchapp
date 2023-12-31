import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class CartAttr with ChangeNotifier {
  final String productName;

  final String productId;

  final List imageUrl;

  int quantity;

  int productQuantity;

  final double price;

  final String vendorId;

  final String productSize;

  Timestamp scheduleDate;

  CartAttr(
      {required this.productName,
      required this.productId,
      required this.imageUrl,
      required this.quantity,

      required this.productQuantity,
      required this.price,
      required this.vendorId,
      required this.productSize,
      required this.scheduleDate});

  void increase() {
    quantity++;
  }

  void decrease() {
    quantity--;
  }
}

class Product {
  final String id;
  final String title;
  final String description;
  final String price;
  final String image;
   int quantity;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.quantity,
  });

  // Factory method to create a Product instance from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      image: json['image'] as String,
      quantity: json['quantity'] as int
    );
  }

  // Method to convert a Product instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      "quantity":quantity
    };
  }
}

