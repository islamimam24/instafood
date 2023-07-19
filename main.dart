// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:instafood/routes/routes.dart';
import 'package:get/get.dart';

import 'package:instafood/dependencies//dependencies.dart' as dep;
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // a flutter method that makes sure that your dependencies are properly loaded
  await dep.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.find<AuthController>().getCurrentUserData;
    // Get.find<CartController>().getCartListStorage;
    return GetMaterialApp(
      initialRoute: AppRoutes.getSplash(),
      getPages: AppRoutes.routes,
    );
  }
}

//TODO LIST
///     * You should save your fave globally
///     * See why simulator is running slow

///     ** save faveList to local storage
///     * locationnn + studiesssssss
