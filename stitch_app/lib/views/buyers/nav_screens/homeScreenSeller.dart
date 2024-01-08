import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/servicesDetailScreen.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/welsom.dart';
import 'package:velocity_x/velocity_x.dart';

import 'widgets/welcome_text_widget.dart';

class ServicesGrid extends StatefulWidget {
  @override
  State<ServicesGrid> createState() => _ServicesGridState();
}

class _ServicesGridState extends State<ServicesGrid> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? searchingText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
            Welsome(name:"Home"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Services',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Search For Services',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        searchingText = null;
                        setState(() {});
                      },
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                        'assets/icons/search.svg',
                        width: 10,
                      ),
                    )),
                onChanged: (val) {
                  searchingText = val;
    
                  setState(() {});
                },
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: searchingText == null
                ? FirebaseFirestore.instance
                    .collection('services')
                    .where("userId", isEqualTo: _auth.currentUser!.uid)
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection('services')
                    .where("userId", isEqualTo: _auth.currentUser!.uid)
                    .where("name", isGreaterThanOrEqualTo: searchingText)
                    .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
    
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
    
              List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                  snapshot.data!.docs;
    
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  mainAxisExtent: 150,
                ),
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var data = documents[index].data();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          data['image'],
                          height: 100,
                          fit: BoxFit.cover,
                          width: 150,
                        ),
                      ),
                      5.heightBox,
                      'Name:${data['name']}'.text.black.bold.make(),
                      'Price: ${data['price']}\$'.text.black.bold.make(),
                    ],
                  ).box.white.outerShadow.rounded.make().onTap(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => ServicesDetailScreen(
                                  image: data['image'],
                                  name: data['name'],
                                  price: data['price'],
                                  description: data['description'],
                                  id: documents[index].id,
                                  time: data['time'],
                                )));
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String price;
  final String title;
  final String hour;
  final String description;
  final String id;

  ServiceCard({
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.hour,
    required this.description,
    required this.id,
  });
 
 


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price: $price',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Title: $title'),
                Text('Hour: $hour'),
                Text('Description: $description'),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // _showEditDialog(context, id, price, title, hour, description);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await FirebaseFirestore.instance
                        .collection("services")
                        .doc(id)
                        .delete();
                  } catch (e) {
                    print('Error deleting document: $e');
                  }
                  // Call your Firebase delete function or use a service class
                  // to handle the deletion of the task
                  // Example: FirebaseService.deleteTask(task.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
