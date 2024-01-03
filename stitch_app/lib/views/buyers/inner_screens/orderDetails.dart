import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderDetails extends StatefulWidget {
  final String? docId;
  final String? username;
  final String? totalamout;
  final String? address;
  final String? phone;

  const OrderDetails(
      {super.key,
      required this.docId,
      required this.address,
      required this.phone,
      required this.totalamout,
      required this.username});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: ListView(

        children: [
          " Products".text.fontWeight(FontWeight.bold).size(18).make(),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("orders")
                  .doc(widget.docId)
                  .collection("list")
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child:
                        CircularProgressIndicator(color: Colors.blue.shade900),
                  );
                } else {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data.docs[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.network(
                              data['image'],
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            10.widthBox,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Title: ${data['title']}".text.make(),
                                "Description: ${data['description']}"
                                    .text
                                    .make(),
                                  "Quantity: ${data['quantity']}"
                                    .text
                                    .make(),
                                "Price: ${data['price'].toString()}\$"
                                    .text
                                    .bold
                                    .make(),
                              ],
                            ),
                          ],
                        )
                            .box
                            .rounded
                            .white
                            .padding(EdgeInsets.all(10))
                            .outerShadow
                            .make();
                      });
                }
              }),
          10.heightBox,
          " Delivery Details".text.fontWeight(FontWeight.bold).size(18).make(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    "Name: ".text.bold.make(),
                    Text(
                      widget.username.toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    "Phone Number: ".text.bold.make(),
                    Text(
                      widget.phone.toString() ,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    "Total Amount: ".text.bold.make(),
                    Text(
                      widget.totalamout.toString() + "\$",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    "Address: ".text.bold.make(),
                    Text(
                      widget.address.toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ).box.white.outerShadow.padding(EdgeInsets.all(8)).rounded.make(),
          )
        ],
      ),
    );
  }
}
