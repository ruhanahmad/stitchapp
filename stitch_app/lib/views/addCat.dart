import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stitch_app/controllers/auth_controller.dart';
import 'package:stitch_app/utils/show_snackBar.dart';
import 'package:stitch_app/views/buyers/auth/login_screen.dart';
import  "package:fluttertoast/fluttertoast.dart";

class AddCartScreen extends StatefulWidget {
  @override
  State<AddCartScreen> createState() => _AddCartScreenState();
}

class _AddCartScreenState extends State<AddCartScreen> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;

  late String fullName;

  late String phoneNumber;

  late String price;

  bool _isLoading = false;

  Uint8List? _image;
 final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
    addServices(email, fullName, phoneNumber, price, _image,selectedRole) async{
      EasyLoading.show(status: "Running");
 String profileImageUrl = await _uploadProfileImageToStorage(_image);

   if (selectedService.isNotEmpty &&
        email.isNotEmpty &&
        fullName.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        price.isNotEmpty 
        
        ) {
      await _firestore.collection('services').add({
        'category': selectedService,
        'name': email,
        'description': fullName,
        'time': phoneNumber,
        'price': price,
        "image":profileImageUrl,
        "userId":_auth.currentUser!.uid
      });

     // Clear text field controllers after saving
      email.clear();
      fullName.clear();
      phoneNumber.clear();
      price.clear();

      // You can add further logic or navigation after saving
      EasyLoading.dismiss();
      print('Service saved successfully!');
    } else {
       EasyLoading.dismiss();
      print('Please fill in all fields');
    }

}

  _uploadProfileImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('servicePics').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  // _signUpUser(String selectedRole) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   if (_formKey.currentState!.validate()) {
  //     await _authController
  //         .signUpUSers(email, fullName, phoneNumber, password, _image,selectedRole)
  //         .whenComplete(() {
  //       setState(() {
  //         _formKey.currentState!.reset();
  //         _isLoading = false;
  //       });
  //     });

  //     return showSnack(
  //         context, 'Congratulations Account has been Created For You');
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     return showSnack(context, 'Please Fields must not be empty');
  //   }
  // }

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);

    setState(() {
      _image = im;
    });
  }
String selectedRole = 'customer'; // Default value
  late List<String> serviceList;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
@override
  void initState() {
    super.initState();
    _servicesStream = _firestore
        .collection('cat')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc['name'] as String)
            .toList());
  }
  
  Future<void> fetchServices() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('cat').get();

    setState(() {
      serviceList = snapshot.docs.map((doc) => doc.id).toList();
    });
  }
  late Stream<List<String>> _servicesStream;
  String selectedService = '';

 
  // _signUpUser() async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add Service',
                  style: TextStyle(fontSize: 20),
                ),
                Stack(
                  children: [
                    _image != null
                        ? 
                        Container(
  width: 128,
  height: 128,
  decoration: BoxDecoration(
    // shape: BoxShape.circle,
    color: Colors.blue.shade900,
    image: DecorationImage(
      fit: BoxFit.cover,
      image: 
      MemoryImage(_image!),
    ),
  ),
)
                        // CircleAvatar(
                        //     radius: 64,
                        //     backgroundColor: Colors.blue.shade900,
                        //     backgroundImage: MemoryImage(_image!),
                        //   )
                        : 
                       Container(
  width: 208,
  height: 208,
  decoration: BoxDecoration(
    // shape: BoxShape.circle,
    color: Colors.blue.shade900,
    image: DecorationImage(
      fit: BoxFit.cover,
      image: NetworkImage(
          'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
    ),
  ),
),
                    Positioned(
                      right: 0,
                      top: 5,
                      child: IconButton(
                        onPressed: () {
                          selectGalleryImage();
                        },
                        icon: Icon(
                          CupertinoIcons.photo,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please name must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Description must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      fullName = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Description',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please hour must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter hour',
                    ),
                  ),
                ),
                   Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please price must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      price = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Price',
                    ),
                  ),
                ),
             ElevatedButton(
              onPressed: () {
                showBottomSheet(context);
              },
              child: Text('Select a service'),
            ),
                // Padding(
                //   padding: const EdgeInsets.all(13.0),
                //   child: TextFormField(
                //     obscureText: true,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'Please Password must not be empty';
                //       } else {
                //         return null;
                //       }
                //     },
                //     onChanged: (value) {
                //       password = value;
                //     },
                //     decoration: InputDecoration(
                //       labelText: 'Password',
                //     ),
                //   ),
                // ),
                   Text("${selectedService}"),
        
                GestureDetector(
                  onTap: ()async {
                     List<DocumentSnapshot> documents = [];
  List cardEx = [];

  String? typeofUser;


    documents.clear();
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('services')
        .where('category', isEqualTo: selectedService)
        .where('userId', isEqualTo: _auth.currentUser!.uid)
     
        .get();
    documents = result.docs;
  
    print(documents.length);
    if (documents.length > 0) {
    // EasyLoading.showError(,duration: Duration(days:1));
    // Fluttertoast.showToast(msg: "Service Already Adeed");
    Get.snackbar("Error", "Service Already Added");
                  }
                  else {
  addServices(email, fullName, phoneNumber, price, _image,selectedService);
                  }
      // print(documents.first["inOut"]);
     
                
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Add Service',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                ),
                              )),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text('Already Have An Account?'),
                //     TextButton(
                //       onPressed: () {
                //         Navigator.push(context,
                //             MaterialPageRoute(builder: (context) {
                //           return LoginScreen();
                //         }));
                //       },
                //       child: Text('Login'),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
    void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder<List<String>>(
          stream: _servicesStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<String> serviceList = snapshot.data!;
              return ListView.builder(
                itemCount: serviceList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(serviceList[index]),
                    onTap: () {
                      setState(() {
                        selectedService = serviceList[index];
                        // nameController.text = selectedService;
                      });
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        );
      },
    );
  }

  
}
