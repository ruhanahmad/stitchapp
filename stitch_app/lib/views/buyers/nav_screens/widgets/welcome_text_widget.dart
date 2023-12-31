import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stitch_app/vendor/controllers/userController.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     UserController userController = Get.put(UserController());
    return
    GetBuilder<UserController>(builder: (builder){
      return     Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 25, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Dear, What Are You\n Looking For 👀',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Stack(

            children: [
              Positioned(child: Container(
              child: SvgPicture.asset(
                'assets/icons/cart.svg',
                width: 20,
              ),
            ),
            
            ),
             Positioned(
              bottom: 8,
              child: Container(
                height: 17,
                width: 17,
                decoration: BoxDecoration(
 color: Colors.red,
                ),
               
              child: 
              Text("${userController.playersList.length}",style: TextStyle(color: Colors.white),)
            ),
            
            ),


            ],
            
          )
        ],
      ),
    );
    });
 
  }
}
