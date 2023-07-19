import 'package:flutter/material.dart';
import 'package:instafood/controllers/auth_controller.dart';
import 'package:instafood/pages/cart/cart_history.dart';
import 'package:instafood/pages/favorite/fave_tap.dart';
import 'package:instafood/pages/profile/profile_page.dart';
import 'package:instafood/pages/signin/signin_page.dart';
import 'package:instafood/pages/signup/signup_page.dart';
import 'package:instafood/utils/colors.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import 'main_home_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedPageIndex = 0;
  List pageList = [
    const HomeScreen(),
    const FavTap(),
    const CartHistory(),
    ProfilePage(),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pageList[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapNav,
        currentIndex: _selectedPageIndex,
        // backgroundColor: AppColors.beforeHomeColor,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Cart History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
