import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stitch_app/views/buyers/productDetail/product_detail_screen.dart';

class HomeproductWidget extends StatelessWidget {
  final String categoryName;

  const HomeproductWidget({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('services')
        .where('category', isEqualTo: categoryName)
        // .where('approved', isEqualTo: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading.....");
        }

        return Container(
          height: 270,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                return Card(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 130,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  productData['image'][0],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          productData['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                         
                              productData['time'] + "hour",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '\$' +
                              " " +
                              productData['price'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                );
              },
              separatorBuilder: (context, _) => SizedBox(
                    width: 15,
                  ),
              itemCount: snapshot.data!.docs.length),
        );
      },
    );
  }
}
