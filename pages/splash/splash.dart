import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:instafood/controllers/cart_controller.dart';
import 'package:instafood/controllers/google_auth.dart';
import 'package:instafood/controllers/standard_auth.dart';
import 'package:instafood/controllers/users_data.dart';
import 'package:instafood/models/user_model.dart';
import 'package:instafood/routes/routes.dart';
import 'package:instafood/utils/colors.dart';
import 'package:instafood/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_products_controller.dart';
import '../signup/signup_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  UserModel userModel = UserModel();
  Future<void> _loadSources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductsController>().getRecommendedProductsList();
    await Get.find<UsersData>().getUsersData();
    await Get.find<UsersData>().getSavdUserDataModel();
    userModel =
        Get.find<UsersData>().savedUserModel == null ? UserModel() : Get.find<UsersData>().savedUserModel!;
  }

  @override
  void initState() {
    super.initState();
    _loadSources();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward(); // .. is to get instance from AnimationController class
    animation = CurvedAnimation(parent: animationController, curve: Curves.linear);

    Timer(const Duration(milliseconds: 1200), () => initNavigation());
    animation.addListener(() {
      setState(() {
        animation.value;
      });
    });
  }

  initNavigation() {
    if (userModel.email == null) {
      Get.toNamed(AppRoutes.getSignInPage());
    } else {
      print(userModel.toJson());
      if (userModel.email!.isNotEmpty &&
          userModel.password!.isNotEmpty &&
          userModel.phone != null &&
          userModel.photoURL == null) {
        Get.find<AuthController>().signInValidation(Get.find<StandardAuth>(), userModel);
        Get.find<AuthController>().signIn(Get.find<StandardAuth>());
      } else if (userModel.email!.isNotEmpty &&
          userModel.password!.isNotEmpty &&
          userModel.photoURL != null) {
        Get.find<AuthController>().signInValidation(Get.find<GoogleAuth>(), userModel);
        Get.find<AuthController>().signIn(Get.find<GoogleAuth>());
      } else {
        Get.toNamed(AppRoutes.getSignInPage());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBasicColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: animation.value, child: Image.asset("assets/images/instafood_logo.png"),
              // child: Image.asset("assets/images/food0.jpg"),
            ),
          ],
        ),
      ),
    );
  }
}
