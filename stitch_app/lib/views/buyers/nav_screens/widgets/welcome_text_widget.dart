import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stitch_app/vendor/controllers/userController.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/cartScreenTwo.dart';

class WelcomeText extends StatelessWidget {

 String name;

 WelcomeText({required this.name});

  @override
  Widget build(BuildContext context) {
     UserController userController = Get.put(UserController());
    return
    GetBuilder<UserController>(builder: (builder){
      return     Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        color: Colors.blue.shade900,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            Stack(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_cart,color: Colors.white,),
              onPressed: () {
                // Handle cart button press
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>CartScreenTwo()));
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
          ),
        ),
      );
    });
 
  }
}
