import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stitch_app/views/buyers/auth/login_screen.dart';
import 'package:stitch_app/views/buyers/inner_screens/edit_profile.dart';
import 'package:stitch_app/views/buyers/inner_screens/order_screen.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/appconst.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/firstScreen.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/welcome_text_widget.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/welsom.dart';

// import '../inner_screens/edit_profile.dart';

class AccountScreenSeller extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return
     _auth.currentUser == null
        ? Scaffold(
          
            // appBar: 
            // aps("Profile"),
            // AppBar(
            //   elevation: 2,
            //   backgroundColor: Colors.blue.shade900,
            //   title: Text(
            //     'Profile',
            //     style: TextStyle(letterSpacing: 4),
            //   ),
            //   centerTitle: true,
            //   actions: [
            //     Padding(
            //       padding: const EdgeInsets.all(14.0),
            //       child: Icon(Icons.star),
            //     ),
            //   ],
            // ),
            body: Column(
              children: [
                  Welsome(name:"Add Service"),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.blue.shade900,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Login Account TO Access Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 200,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                        child: Text(
                      'LOGIN ACCOUNT',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 4,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                  ),
                ),
              ],
            ),
          )
        : 
        
        StreamBuilder<DocumentSnapshot>(
            stream: users.doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
            builder: (context,  snapshot) {
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
              
            //  if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Scaffold(
   
                  body: Column(
                    children: [
                     Welsome(name:"Profile"),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.blue.shade900,
                          backgroundImage: NetworkImage(data['profileImage']),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data['fullName'],
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data['email'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(context,
                      //         MaterialPageRoute(builder: (context) {
                      //       return EditPRofileScreen(
                      //         userData: data,
                      //       );
                      //     }));
                      //   },
                      //   child: Container(
                      //     height: 40,
                      //     width: MediaQuery.of(context).size.width - 200,
                      //     decoration: BoxDecoration(
                      //       color: Colors.blue.shade900,
                      //       borderRadius: BorderRadius.circular(4),
                      //     ),
                      //     child: Center(
                      //         child: Text(
                      //       'Edit Profile',
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           letterSpacing: 4,
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 18),
                      //     )),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return EditPRofileScreen(
                              userData: data,
                            );
                          }));
                        },
                        child: ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Edit Profile'),
                        ),
                      ),
                      // ListTile(
                      //   leading: Icon(Icons.phone),
                      //   title: Text('Phone'),
                      // ),
                      // ListTile(
                      //   leading: Icon(Icons.shop),
                      //   title: Text('Cart'),
                      // ),
                      // ListTile(
                      //   onTap: () {
                      //     Navigator.push(context,
                      //         MaterialPageRoute(builder: (context) {
                      //       return CustomerOrderScreen();
                      //     }));
                      //   },
                      //   leading: Icon(CupertinoIcons.shopping_cart),
                      //   title: Text('Order'),
                      // ),
                      ListTile(
                        onTap: () async {
                          await _auth.signOut().whenComplete(() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FirstScreen();
                            }));
                          });
                        },
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
                      ),
                    ],
                  ),
                );
           // }
             //   AsyncSnapshot<DocumentSnapshot> snapshot) {
           
              }

              // return Center(child: CircularProgressIndicator());
            // },
          );
  }
}
