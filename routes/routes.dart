import 'package:instafood/pages/cart/cart_screen.dart';
import 'package:instafood/pages/food_details/popular_food_details.dart';
import 'package:instafood/pages/food_details/recommended_food_details.dart';
import 'package:instafood/pages/home/main_home_screen.dart';
import 'package:instafood/pages/splash/splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../pages/home/home.dart';
import '../pages/signin/signin_page.dart';
import '../pages/signup/signup_page.dart';

class AppRoutes {
  static const String splash = "/splash";
  static const String initial = "/";

  static const String popularFoodDetails = "/popularFoodPage";
  static const String recommendedFoodDetails = "/recommendedFoodPage";
  static const String cartPage = "/cartPage";
  static const String signUpPage = "/signUpPage";
  static const String signInPage = "/signInPage";

  static String getSplash() => splash;

  static String getHome() => initial;

  static String getPopularFoodDetails(int pageIndex) =>
      "$popularFoodDetails?pageIndex=$pageIndex "; // (2) (see the main page)

  static String getRecommendedFoodDetails(int recommendedPageId) =>
      "$recommendedFoodDetails?recommendedPageId= $recommendedPageId ";

  static String getCartPage() => cartPage;

  static String getSignUpPage() => signUpPage;

  static String getSignInPage() => signInPage;

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashPage(),
    ),
    GetPage(
      name: initial,
      page: () => Home(),
      transition: Transition.cupertino,
    ),
    GetPage(
        name: popularFoodDetails,
        page: () {
          var pageIndex = Get.parameters['pageIndex']; // (3)
          return PopularFoodDetails(
              pageIndex:
                  pageIndex); // (4) whatever value in here it will modify the argument inside PopularFoodDetails()
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFoodDetails,
        page: () {
          var recommendedPageId = Get.parameters['recommendedPageId'];
          return RecommendedFoodDetails(
            recommendedPageId: recommendedPageId,
          );
        }),
    GetPage(name: cartPage, page: () => CartScreen()),
    GetPage(name: signUpPage, page: () => SignUpPage(), transition: Transition.rightToLeftWithFade),
    GetPage(name: signInPage, page: () => SignInPage()),
  ];
}
