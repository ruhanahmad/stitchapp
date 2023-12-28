import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stitch_app/firebase_options.dart';
import 'package:stitch_app/provider/cart_provider.dart';
import 'package:stitch_app/provider/product_provider.dart';
import 'package:stitch_app/views/buyers/main_screen.dart';

import 'package:provider/provider.dart';
import 'package:stitch_app/views/buyers/nav_screens/account_screen.dart';
import 'package:stitch_app/views/buyers/nav_screens/widgets/firstScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
//  await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'your_recaptcha_site_key');
  runApp(MyApp());
  // await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) {
      return ProductProvider();
    }),
    ChangeNotifierProvider(create: (_) {
      return CartProvider();
    })
  ], child: const MyApp()));

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Brand-Bold',
      ),
      home:
      FirstScreen(),
      // MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}
