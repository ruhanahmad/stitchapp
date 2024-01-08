import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stitch_app/vendor/controllers/userController.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/cartScreenTwo.dart';

class Welsome extends StatelessWidget {

 String name;

 Welsome({required this.name});

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
       
            ],
          ),
        ),
      );
    });
 
  }
}
