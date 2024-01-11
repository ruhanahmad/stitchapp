import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stitch_app/views/buyers/nav_screens/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class ServicesScreen extends StatefulWidget {
  final String categoryName;
  const ServicesScreen({super.key, required this.categoryName});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Services"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //   WelcomeText(),

          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("services")
                .where("category", isEqualTo: widget.categoryName)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error Occurred"),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text("Products not found"),
                );
              } else {
                return Expanded(
                  child: Column(
                    children: [
                      //   Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     'Services',
                      //     style: TextStyle(
                      //       fontSize: 24.0,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      GridView.builder(
                        shrinkWrap: true,
                        // restorationId: UniqueKey().toString(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  data['image'],
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              10.heightBox,
                              "Price: ${data['price'].toString()}\$"
                                  .text
                                  .bold
                                  .make(),
                              "Title: ${data['name']}".text.make(),
                              "Description: ${data['description']}".text.make(),
                               10.heightBox,
                                 "Phone Number: ${data['phoneNumber']}".text.make(),
                            ],
                          )
                              .box
                              .rounded
                              .white
                              .padding(EdgeInsets.all(5))
                              .outerShadow
                              .make();
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          )
          // SearchInputWidget(),
          // BannerWidget(),
          // CategoryText(),
        ],
      ),
    );
  }
}
