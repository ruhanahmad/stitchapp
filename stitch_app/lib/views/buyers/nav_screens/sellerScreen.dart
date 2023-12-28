import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stitch_app/views/addCat.dart';
import 'package:stitch_app/views/buyers/nav_screens/homeScreenSeller.dart';

import 'package:stitch_app/views/buyers/nav_screens/home_screen.dart';
import 'package:stitch_app/views/buyers/nav_screens/category_screen.dart';
import 'package:stitch_app/views/buyers/nav_screens/store_screen.dart';
import 'package:stitch_app/views/buyers/nav_screens/cart_screen.dart';
import 'package:stitch_app/views/buyers/nav_screens/search_screen.dart';
import 'package:stitch_app/views/buyers/nav_screens/account_screen.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    ServicesGrid(),
    AddCartScreen(),
    StoreScreen(),
    // CartScreen(),
    // SearchScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue.shade900,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/explore.svg',
              width: 20,
            ),
            label: 'CATEGORIES',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/shop.svg',
              width: 20,
            ),
            label: 'STORE',
          ),
          // BottomNavigationBarItem(
          //   icon: SvgPicture.asset('assets/icons/cart.svg'),
          //   label: 'CART',
          // ),
          // BottomNavigationBarItem(
          //   icon: SvgPicture.asset('assets/icons/search.svg'),
          //   label: 'SEARCH',
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/account.svg'),
            label: 'ACCOUNT',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
