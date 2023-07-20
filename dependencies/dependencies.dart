import 'package:instafood/controllers/auth_controller.dart';
import 'package:instafood/controllers/auth_interface.dart';
import 'package:instafood/controllers/cart_controller.dart';
import 'package:instafood/controllers/cart_history_controller.dart';
import 'package:instafood/controllers/google_auth.dart';
import 'package:instafood/controllers/popular_product_controller.dart';
import 'package:instafood/controllers/recommended_products_controller.dart';
import 'package:instafood/controllers/standard_auth.dart';
import 'package:instafood/controllers/users_data.dart';
import 'package:instafood/data/api/api_client.dart';
import 'package:instafood/data/repository/auth_repo.dart';
import 'package:instafood/data/repository/cart_repo.dart';
import 'package:instafood/data/repository/popular_product_repo.dart';
import 'package:instafood/data/repository/recommended_product_repo.dart';
import 'package:instafood/pages/cart/cart_history.dart';
import 'package:instafood/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  /// api client
  Get.lazyPut(() => APIClient(appBaseUrl: AppConstant.REST_API_URL));

  /// repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  /// interface
  Get.lazyPut(() => IAuth);

  /// controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find(), cartController: Get.find()));
  Get.lazyPut(
      () => RecommendedProductsController(recommendedProductRepo: Get.find(), usersDataIns: Get.find()));
  Get.lazyPut(() => UsersData(authRepo: Get.find()));
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => GoogleAuth(authRepo: Get.find(), usersDataIns: Get.find()));
  Get.lazyPut(() => StandardAuth(authRepo: Get.find(), usersDataIns: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find(), usersDataIns: Get.find()));
  Get.lazyPut(() =>
      CartHistoryController(cartRepo: Get.find(), usersDataIns: Get.find(), cartCottroller: Get.find()));
}
// after this we create a APIClient class that we will call here in init() that will contact directly with main()(((__)))
