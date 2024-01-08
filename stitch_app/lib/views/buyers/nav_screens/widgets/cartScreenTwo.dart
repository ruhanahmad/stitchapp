import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stitch_app/vendor/controllers/userController.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/appconst.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/checkout.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/welcome_text_widget.dart';

import '../../../../models/cart_attributes.dart';



class CartScreenTwo extends StatelessWidget {

   double totalPrice = 0.0;

//  void increaseQuantity(Product product) {
//     setState(() {
//       product.quantity++;
//       totalPrice += product.price;
//     });
//   }

  // double calculateTotalPrice() {

  //   return productList.fold(0.0, (sum, product) => sum + product.price * product.quantity);
  // }
// double calculateTotalPrice() {
//   return
//    productList
//       .map((product) => product.price * product.quantity)
//       .reduce((value, element) => value + element);
// }
UserController usersss = Get.put(UserController());
 double calculateTotalPrice() {
    return usersss.playersList.fold(0.0, (sum, product) => sum + int.parse(product.price) * product.quantity);
  }
  @override
  Widget build(BuildContext context) {
    return 
    
    // MaterialApp(
    //   home: 
    GetBuilder<UserController>(builder: (builder){
      return   Scaffold(
        // appBar: 
    //    AppBar(
    //     title: Text("Cart Screen",style: TextStyle(color: Colors.white),),
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
        // AppBar(
        //   title: Text('Product List'),
        // ),
        body: Column(
          children: [
             WelcomeText(name:"Cart"),

              builder.playersList.length == 0 ?
            Padding(
              padding: const EdgeInsets.only(top:50.0),
              child: Container(child: Center(child: Text("Your Cart is Empty",style: TextStyle(fontSize: 30),)),),
            ) :
            Expanded(
              child: ListView.builder(
                itemCount: builder.playersList.length,
                itemBuilder: (context, index) {
                  // Get the current product
                  // Product product = products[index];
              
                  // Return a Container with Row for each product
                  return 
                  
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.network(
                          builder.playersList[index].image,
                          width: 80.0,
                          height: 80.0,
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text( builder.playersList[index].title),
                              Text('Description: ${ builder.playersList[index].description}'),
                              Text('Price: \$${ builder.playersList[index].price.toString()}'),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                if ( builder.playersList[index].quantity > 1) {
                                  // Decrease quantity
                                   builder.playersList[index].quantity--;
                                   builder.update();
                                }
                                // else {
                                //   if ( builder.playersList[index].quantity < 1) {
                                //   // Decrease quantity
                                //   builder.playersList.removeAt(index);
                                //    builder.update();
                                // } 
                                // }
                              },
                            ),
                            Text( builder.playersList[index].quantity.toString()),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                // Increase quantity
                                 builder.playersList[index].quantity++;
                                 builder.totalPrice += int.parse(builder.playersList[index].price);
                                 builder.update();
                                //  increaseQuantity(product);
                              },
                            ),
              
                              IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Increase quantity
                                 builder.playersList.removeAt(index);
                                 builder.update();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
 
//          Text(int.parse(builder.playersList.map((element) => element.price ++)) )
// // Text( builder.playersList
//       .map((product) => product.price * product.quantity)
//       .reduce((value, element) => value + element)),
            // Text(builder.playersList.fold( 0, (sum, product) => sum + product.price * product.quantity))
            builder.playersList.length == 0 ?
            Container(child: Center(child: Text("")),)
        //  Container(
        //           color: Colors.red,
        //           height: 60,
        //           width: 150,
        //           child: Center(child: Text("Nothing in a Cart",style: TextStyle(color: Colors.white,fontSize: 20),)),
        //         )
            :
   Column(
     children: [
       Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderScreen(total:calculateTotalPrice().toStringAsFixed(2))));
              //  Get.to(()=> )    ;  
                    },
                    child: 
                    Container(
                      color: Colors.red,
                      height: 60,
                      width: 150,
                      child: Center(child: Text("Checkout",style: TextStyle(color: Colors.white,fontSize: 20),)),
                    ),
                  ),
                ),
                Obx(() {
          return  Text('Total Price: \$${calculateTotalPrice()}');
          }),
     ],
   )
 
          ],
        ),
      );
    });
    
    // );
  }
}
