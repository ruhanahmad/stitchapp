import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import "package:stitch_app/views/buyers/nav_screens/category_screen.dart";
import 'package:stitch_app/views/buyers/nav_screens/widgets/appconst.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/home_products.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/mian_products_widget.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/welcome_text_widget.dart';
import 'package:stitch_app/views/services/servicesScreen.dart';

class CategoryText extends StatefulWidget {
  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? _selectedCategory;
  String? searchingText = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //   appBar: 
    //   AppBar(
    //     title: Text("Categories",style: TextStyle(color: Colors.white),),
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
    //   ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            WelcomeText(name:"Categories"),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Search For Categories',
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
          StreamBuilder(
            stream: searchingText == null
                ? FirebaseFirestore.instance.collection("cat").snapshots()
                : FirebaseFirestore.instance
                    .collection("cat")
                    .where("name", isEqualTo: searchingText)
                    .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
            
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Loading categories"),
                );
              }
            
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final categoryData = snapshot.data!.docs[index];
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (bulder)=>ServicesScreen(
                                  categoryName: categoryData['name'],
                                )));
                          },
                          tileColor: const Color.fromARGB(255, 12, 56, 91),
                          title: Text(
                            categoryData['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ));
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
