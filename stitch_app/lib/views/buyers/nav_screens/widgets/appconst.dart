import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stitch_app/vendor/controllers/userController.dart';

UserController userController = Get.put(UserController());
AppBar aps(String name) {
  return
  
      AppBar(
        title: Text(name,style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
     elevation: 2,
              backgroundColor: Colors.blue.shade900,
              actions: [
//                     Stack(

//             children: [
//               Positioned(child: Container(
//               child: SvgPicture.asset(
//                 'assets/icons/cart.svg',
//                 width: 20,
//               ),
//             ),
            
//             ),
//              Positioned(
//               bottom: 8,
//               child: 
//               Container(
//                 height: 17,
//                 width: 17,
//                 decoration: BoxDecoration(
//  color: Colors.red,
//                 ),
               
//               child: 
//               Text("${userController.playersList.length}",style: TextStyle(color: Colors.white),)
//             ),
            
//             ),


//             ],
            
//           ),



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
}

