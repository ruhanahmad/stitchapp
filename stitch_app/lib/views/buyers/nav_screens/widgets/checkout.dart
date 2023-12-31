import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stitch_app/models/cart_attributes.dart';
import 'package:stitch_app/vendor/controllers/userController.dart';

class OrderScreen extends StatefulWidget {
  String total;
  OrderScreen({required this.total});
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
UserController userController = Get.put(UserController());
  void placeOrder() async {
    // Get user input
    String name = nameController.text;
    String phoneNumber = phoneNumberController.text;
    String address = addressController.text;
//  List<Map<String, dynamic>> formattedList =
//         userController.playersList.map((item) => {"value": item}).toList();

    // Store order in the "orders" collection
    DocumentReference id =   await FirebaseFirestore.instance.collection('orders').add({
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'timestamp': FieldValue.serverTimestamp(),
      // "orderList":formattedList,
      "total":widget.total,
      "userId":FirebaseAuth.instance.currentUser!.uid
    });
print(id);
for (Product product in userController.playersList) {
      //await productsCollection.doc(product.id).set(product.toMap());
      await FirebaseFirestore.instance.collection('orders').doc(id.id).collection("list").add(product.toJson());
    }

    // Display a confirmation message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Placed'),
          content: Text('Your order has been placed successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    nameController.clear();
    phoneNumberController.clear();
    addressController.clear();
    userController.playersList.clear();
    userController.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 16.0),
            Text('This is cash on delivery'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: placeOrder,
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
