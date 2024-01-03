import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stitch_app/vendor/controllers/userController.dart';

UserController userController = Get.put(UserController());
 aps(String name) {
 
 return   GetBuilder<UserController>(builder: (_){
   return 
   AppBar(
        title: Text(name,style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
     elevation: 2,
              backgroundColor: Colors.blue.shade900,
              actions: [




              Stack(
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart,color: Colors.white,),
          onPressed: () {
            // Handle cart button press
          },
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
             "${userController.playersList.length}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    )
              ],
      );
  });
      
}

