import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditPRofileScreen extends StatefulWidget {
  final dynamic userData;

  EditPRofileScreen({super.key, required this.userData});

  @override
  State<EditPRofileScreen> createState() => _EditPRofileScreenState();
}

class _EditPRofileScreenState extends State<EditPRofileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  String? image;
  String? address;
  @override
  void initState() {
    setState(() {
      _fullNameController.text = widget.userData['fullName'];
      _emailController.text = widget.userData['email'];
      _phoneController.text = widget.userData['phoneNumber'];
  image = widget.userData["profileImage"];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 6,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blue.shade900,
                        backgroundImage: NetworkImage(  widget.userData["profileImage"] == null   ? "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg" : widget.userData["profileImage"]),
                    ),
                    // Positioned(
                    //   right: 40,
                    //   child: IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(CupertinoIcons.photo),
                    //   ),
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Enter Full Name',
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextFormField(
                //     controller: _emailController,
                //     decoration: InputDecoration(
                //       labelText: 'Enter Email',
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Enter Phone',
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextFormField(
                //     onChanged: (value) {
                //       address = value;
                //     },
                //     decoration: InputDecoration(
                //       labelText: 'Enter Address',
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(13.0),
        child: InkWell(
          onTap: () async {
            EasyLoading.show(status: 'UPDATING');
            await _firestore
                .collection('buyers')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              'fullName': _fullNameController.text,
              'email': _emailController.text,
              'phoneNumber': _phoneController.text,
              'address': address,
            }).whenComplete(() {
              EasyLoading.dismiss();
setState(() {
  
});
               Navigator.pop(context);
            });
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Text(
              'UPDATE',
              style: TextStyle(
                  color: Colors.white, fontSize: 18, letterSpacing: 6),
            )),
          ),
        ),
      ),
    );
  }
}
