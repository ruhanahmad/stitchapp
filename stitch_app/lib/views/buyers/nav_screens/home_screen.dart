import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stitch_app/models/cart_attributes.dart';
import 'package:stitch_app/vendor/controllers/userController.dart';
import 'package:stitch_app/views/buyers/nav_screens/homeScreenSeller.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/appconst.dart';

import 'package:stitch_app/views/buyers/nav_screens/widgets/banner_widget.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/category_text.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/search_input_widget.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/welcome_text_widget.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? searchingText;
  late TextEditingController _searchController;
  late List<QueryDocumentSnapshot> _initialData;
  List<QueryDocumentSnapshot> _filteredData = [];
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  String searchQuerys = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<QueryDocumentSnapshot> filterData(String searchQuery) {
    return _initialData
        .where((document) => document['user']
            .toString()
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();
  }

  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:
    //    AppBar(
    //     title: Text("Home",style: TextStyle(color: Colors.white),),
    //     automaticallyImplyLeading: false,
    //  elevation: 2,
    //           backgroundColor: Colors.blue.shade900,
    //           actions: [




    //           Stack(
    //   children: [
    //     IconButton(
    //       icon: Icon(Icons.shopping_cart,color: Colors.white,),
    //       onPressed: () {
    //         // Handle cart button press
    //       },
    //     ),
    //     Positioned(
    //       right: 8,
    //       top: 8,
    //       child: Container(
    //         padding: EdgeInsets.all(2),
    //         decoration: BoxDecoration(
    //           color: Colors.red,
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //         constraints: BoxConstraints(
    //           minWidth: 16,
    //           minHeight: 16,
    //         ),
    //         child: Text(
    //          "${userController.playersList.length}",
    //           style: TextStyle(
    //             color: Colors.white,
    //             fontSize: 12,
    //           ),
    //           textAlign: TextAlign.center,
    //         ),
    //       ),
    //     ),
    //   ],
    // )
    //           ],
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeText(name:"Home"),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Search For Products',
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
                ? FirebaseFirestore.instance.collection('products').snapshots()
                : FirebaseFirestore.instance
                    .collection('products')
                    .where("name", isGreaterThanOrEqualTo: searchingText)
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
                      Expanded(
                        child: GridView.builder(
                          // restorationId: UniqueKey().toString(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index];

                            return ServiceCards(
                              imageUrl: data['image'],
                              price: data['price'],
                              title: data['name'],
                              // hour: data['time'],
                              description: data['description'],
                              id: snapshot.data!.docs[index].id,
                              i: index,
                            );
                          },
                        ),
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

class ServiceCards extends StatelessWidget {
  final String imageUrl;
  final String price;
  final String title;
  // final String hour;
  final String description;
  final String id;
  int i;

  ServiceCards(
      {required this.imageUrl,
      required this.price,
      required this.title,
      // required this.hour,
      required this.description,
      required this.id,
      required this.i});
  TextEditingController taskiController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController onTimeController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  //   final UserController _ = Get.find();

  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50.0,
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
                // Text('Hour: $hour'),
                Text('Description: $description'),
                SizedBox(
                  height: 1,
                ),
                GestureDetector(
                    onTap: () {
                      //  userController.playersList.removeAt(i);
                      userController.playersList.add(Product(
                          id: id,
                          title: title,
                          description: description,
                          price: price,
                          image: imageUrl,
                          quantity: 1));
                      userController.update();
                    },
                    child: Container(
                        height: 30,
                        width: 140,
                        decoration: BoxDecoration(color: Colors.black),
                        child: Center(
                            child: Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white),
                        )))),
              ],
            ),
          ),
          // Row(
          //                         mainAxisSize: MainAxisSize.min,
          //                         children: [
          //                           IconButton(
          //                             icon: Icon(Icons.edit),
          //                             onPressed: () {
          //                               _showEditDialog(context, id, price,
          //                                   title, hour, description);
          //                             },
          //                           ),
          //                           IconButton(
          //                             icon: Icon(Icons.delete),
          //                             onPressed: () async {
          //                               try {
          //                                 await FirebaseFirestore.instance
          //                                     .collection("services")
          //                                     .doc(id)
          //                                     .delete();
          //                               } catch (e) {
          //                                 print(
          //                                     'Error deleting document: $e');
          //                               }
          //                               // Call your Firebase delete function or use a service class
          //                               // to handle the deletion of the task
          //                               // Example: FirebaseService.deleteTask(task.id);
          //                             },
          //                           ),
          //                         ],
          //                       ),
        ],
      ),
    );
  }
}
